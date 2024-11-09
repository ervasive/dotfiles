-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Mouse code navigation
vim.keymap.set(
  "n",
  "<RightMouse>",
  '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<C-ScrollWheelUp>", "<C-i>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-ScrollWheelDown>", "<C-o>", { noremap = true, silent = true })
