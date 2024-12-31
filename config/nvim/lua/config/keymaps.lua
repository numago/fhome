-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map jj to esc
vim.api.nvim_set_keymap("i", "jj", "<esc>", { noremap = true, silent = true, expr = false })

-- This keymap is for copying the full path of the current buffer file to the clipboard using the 'cc' command.
vim.api.nvim_set_keymap(
  "n",
  "yY",
  ":lua vim.cmd('!copy-context.sh ' .. vim.fn.expand('%:p'))<CR>",
  { noremap = true, silent = false, desc = "Copy current file to clipboard" }
)
