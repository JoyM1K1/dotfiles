#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { execSync } = require('child_process');

// Constants
const COMPACTION_THRESHOLD = 200000 * 0.8

// Read JSON from stdin
let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', async () => {
  try {
    const data = JSON.parse(input);

    // Extract values
    const model = data.model?.display_name || 'Unknown';
    const currentDir = data.workspace?.current_dir || data.cwd || '.';
    const sessionId = data.session_id;
    const outputStyle = data.output_style?.name || 'default';

    // Get time
    const currentTime = new Date().toLocaleTimeString('en-US', { 
      hour12: false, 
      hour: '2-digit', 
      minute: '2-digit', 
      second: '2-digit' 
    });

    // Get git branch if available
    let gitBranch = '';
    try {
      const branch = execSync('git branch 2>/dev/null | grep "^*" | colrm 1 2', { 
        cwd: currentDir,
        encoding: 'utf8',
        timeout: 1000
      }).trim();
      if (branch) {
        gitBranch = ` \x1b[38;5;213m${branch}\x1b[0m`;
      }
    } catch (e) {
      // No git repo or error, ignore
    }

    // Calculate token usage for current session
    let totalTokens = 0;

    if (sessionId) {
      // Find all transcript files
      const projectsDir = path.join(process.env.HOME, '.claude', 'projects');

      if (fs.existsSync(projectsDir)) {
        // Get all project directories
        const projectDirs = fs.readdirSync(projectsDir)
          .map(dir => path.join(projectsDir, dir))
          .filter(dir => fs.statSync(dir).isDirectory());

        // Search for the current session's transcript file
        for (const projectDir of projectDirs) {
          const transcriptFile = path.join(projectDir, `${sessionId}.jsonl`);

          if (fs.existsSync(transcriptFile)) {
            totalTokens = await calculateTokensFromTranscript(transcriptFile);
            break;
          }
        }
      }
    }

    // Calculate percentage
    const percentage = Math.min(100, Math.round((totalTokens / COMPACTION_THRESHOLD) * 100));
    const remainingPercentage = 100 - percentage;

    // Format token display
    const tokenDisplay = formatTokenCount(totalTokens);

    // Color coding for remaining percentage
    let percentageColor = '\x1b[32m'; // Green
    if (remainingPercentage <= 30) percentageColor = '\x1b[33m'; // Yellow
    if (remainingPercentage <= 10) percentageColor = '\x1b[31m'; // Red

    // Build status line
    const dirDisplay = path.basename(currentDir);
    const statusLine = `\x1b[93;1m${currentTime}\x1b[0m \x1b[92m${dirDisplay}\x1b[0m [\x1b[94m${model}\x1b[0m] \x1b[95m${outputStyle}\x1b[0m${gitBranch} 💰 ${tokenDisplay} ${percentageColor}${remainingPercentage}% context left\x1b[0m`;

    console.log(statusLine);
  } catch (error) {
    // Fallback status line on error
    console.log('\x1b[31m[Error]\x1b[0m');
  }
});

async function calculateTokensFromTranscript(filePath) {
  return new Promise((resolve, reject) => {
    let lastUsage = null;

    const fileStream = fs.createReadStream(filePath);
    const rl = readline.createInterface({
      input: fileStream,
      crlfDelay: Infinity
    });

    rl.on('line', (line) => {
      try {
        const entry = JSON.parse(line);

        // Check if this is an assistant message with usage data
        if (entry.type === 'assistant' && entry.message?.usage) {
          lastUsage = entry.message.usage;
        }
      } catch (e) {
        // Skip invalid JSON lines
      }
    });

    rl.on('close', () => {
      if (lastUsage) {
        // The last usage entry contains cumulative tokens
        const totalTokens = (lastUsage.input_tokens || 0) +
          (lastUsage.output_tokens || 0) +
          (lastUsage.cache_creation_input_tokens || 0) +
          (lastUsage.cache_read_input_tokens || 0);
        resolve(totalTokens);
      } else {
        resolve(0);
      }
    });

    rl.on('error', (err) => {
      reject(err);
    });
  });
}

function formatTokenCount(tokens) {
  if (tokens >= 1000000) {
    return `${(tokens / 1000000).toFixed(1)}M`;
  } else if (tokens >= 1000) {
    return `${(tokens / 1000).toFixed(1)}K`;
  }
  return tokens.toString();
}
