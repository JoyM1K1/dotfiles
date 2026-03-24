#!/usr/bin/env node

const path = require('path');
const { execSync } = require('child_process');

// Read JSON from stdin
let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input);

    // Extract values
    const model = data.model?.display_name || 'Unknown';
    const currentDir = data.workspace?.current_dir || data.cwd || '.';
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

    // Context window info from input data
    const contextWindow = data.context_window || {};
    const remainingPercentage = contextWindow.remaining_percentage ?? 100;
    const inputTokens = contextWindow.current_usage?.input_tokens || 0;
    const tokenDisplay = formatTokenCount(inputTokens);

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

function formatTokenCount(tokens) {
  if (tokens >= 1000000) {
    return `${(tokens / 1000000).toFixed(1)}M`;
  } else if (tokens >= 1000) {
    return `${(tokens / 1000).toFixed(1)}K`;
  }
  return tokens.toString();
}
