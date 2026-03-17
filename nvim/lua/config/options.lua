-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local function clear_bg()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "SignColumn",
    "FloatBorder",
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

local grp = vim.api.nvim_create_augroup("transparent_background", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = clear_bg })
vim.api.nvim_create_autocmd("VimEnter", { group = grp, callback = clear_bg })
