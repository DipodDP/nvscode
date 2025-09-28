-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "C-o", "<NOP>")
map("n", "C-i", "<NOP>")

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv")
map("x", "K", ":move '<-2<CR>gv")
-- Clear highlights and prints
map("n", "<LEADER>n", '<CMD>noh<CR><cmd>echo ""<CR>')
-- Copy path to clipboard
map("n", "<LEADER>yf", '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:."))<CR>')
map("n", "<LEADER>yl", '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))<CR>')
--
-- -- TUI/GUI NeoVim only settings
-- if not vim.g.vscode then
--   -- Resize with arrows
--   map("n", "<C-Up>", "<CMD>resize +2<CR>")
--   map("n", "<C-Down>", "<CMD>resize -2<CR>")
--   map("n", "<C-Left>", "<CMD>vertical resize -2<CR>")
--   map("n", "<C-Right>", "<CMD>vertical resize +2<CR>")
--
--   -- Improve window navigation
--   -- map("n", "<C-h>", "<C-w>h")
--   -- map("n", "<C-j>", "<C-w>j")
--   -- map("n", "<C-k>", "<C-w>k")
--   -- map("n", "<C-l>", "<C-w>l")
--   -- map("t", "<ESC><ESC>", "<C-\\><C-n>")
--   -- map("t", "<C-h>", "<CMD>wincmd h<CR>")
--   -- map("t", "<C-j>", "<CMD>wincmd j<CR>")
--   -- map("t", "<C-k>", "<CMD>wincmd k<CR>")
--   -- map("t", "<C-l>", "<CMD>wincmd l<CR>")
--
--   -- Tab navigation
--   map("n", "<LEADER>tt", "<CMD>$tabnew<CR>")
--   map("n", "<LEADER>tq", "<CMD>tabclose<CR>")
--   map("n", "<LEADER>tn", "<CMD>tabnext<CR>")
--   map("n", "<LEADER>tp", "<CMD>tabprev<CR>")
--
--   -- Delete selection into void register before pasting
--   map("x", "<LEADER>p", '"_dP')
--
--   -- LSP
--   map("n", "<LEADER>k", vim.diagnostic.open_float)
--   map("n", "[d", vim.diagnostic.goto_prev)
--   map("n", "]d", vim.diagnostic.goto_next)
-- end

-- comment line
map("n", "<leader>/", "<cmd>normal gcc<CR>", { desc = "Comment" })
map("v", "<leader>/", "<cmd>normal gc<CR>", { desc = "Comment" })

-- quick clear highlighting
map("n", "<C-[>", "<cmd>nohlsearch<cr>", opts)

-- next quickfix item
map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- escape
map("i", "jk", "<ESC>:w<CR>", opts)
map("i", "jj", "<ESC>:w<CR>", opts)

-- Better registers
map("x", "p", [["_dP]], opts)
-- Cut selected
map("v", "x", "ygvx")
-- Delete in blackhole register
map("n", "c", '"_c', opts)
map("v", "c", '"_c', opts)
map("v", "DD", '"_d', opts)
-- map("v", "Y", "<CMD>lua require('osc52').copy_visual()<CR>", opts)A

-- buffers
map("n", "X", ":bdelete!<CR>", opts)
-- map("n", "L", ":BufferLineCycleNext<CR>", opts)
-- map("n", "H", ":BufferLineCyclePrev<CR>", opts)
map("n", "gl", vim.diagnostic.open_float, opts)
map("n", ";p", '"0p', opts)
map("n", ";c", '"_c', opts)
map("n", ";d", '"_d', opts)

if vim.g.vscode then
  require("code.keymaps")
else
  local term = require("snacks.terminal")
  local lazygit = require("snacks.lazygit")
  -- quick window quit
  map("n", "<leader>qw", ":q<cr>", { noremap = true, silent = true, desc = "quit window" })
  -- leader backspace to delete buffer
  map("n", "<leader><bs>", ":bd<cr>", { noremap = true, silent = true, desc = "delete buffer" })
  -- resume telescope after exiting
  map("n", "<leader>;", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>")

  map("n", "gA", vim.lsp.codelens.run, opts)

  map(
    "n",
    "gv",
    "<cmd>vsplit | lua vim.lsp.buf.definition({on_list = function(items) vim.fn.setqflist({}, 'r', items) vim.cmd('cfirst') end})<cr>",
    opts
  )

  map("n", "ga", function()
    require("tiny-code-action").code_action()
  end, opts)

  map("n", "<leader>st", LazyVim.pick("live_grep"), opts)
  -- map("n", "<leader>sT", "<cmd>TodoTelescope<cr>", opts)
  map("n", "<leader>sL", require("config.telescope").multigrep, opts)
  map("n", "<leader>cs", "<cmd>Outline<cr>", opts)
  map("n", "<c-`>", function()
    Snacks.terminal()
  end, { desc = "Toggle Terminal" })
  -- floating terminal
  map("n", "<c-/>", function()
    term.toggle()
  end, { desc = "Terminal (root dir)" })

  -- git
  map("n", "<leader>gg", function()
    lazygit.open()
  end, { desc = "Lazygit (root dir)" })
end

-- -- run last ran command
-- map("n", "<leader>ol", "<cmd>OverseerRestartLast<cr>", { desc = "Overseer Run Last" })
--
-- -- comment line
-- map("n", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })
-- map("v", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })
--
-- -- quick clear highlighting
-- map("n", "<C-[>", "<cmd>nohlsearch<cr>", opts)
--
-- -- next quickfix item
-- map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })
--
-- -- prev quickfix item
-- map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })
--
-- -- better redo
-- map("n", "U", "<c-r>", { noremap = true, silent = true, desc = "redo" })
--
-- -- quick window quit
-- map("n", "<leader>qw", ":q<cr>", { noremap = true, silent = true, desc = "quit window" })
--
-- -- leader backspace to delete buffer
-- map("n", "<leader><bs>", ":bd<cr>", { noremap = true, silent = true, desc = "delete buffer" })
--
-- -- resume telescope after exiting
-- map("n", "<leader>;", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>")
--
-- -- move line up and down
-- map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
-- map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })
--
-- -- better indenting
-- map("v", "<", "<gv", { desc = "Indent left" })
-- map("v", ">", ">gv", { desc = "Indent right" })

-- map(
--   "n",
--   "<leader>gj",
--   "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>",
--   { noremap = true, silent = true, desc = "Next Hunk" }
-- )
-- map(
--   "n",
--   "<leader>gk",
--   "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>",
--   { noremap = true, silent = true, desc = "Prev Hunk" }
-- )
-- map(
--   "n",
--   "<leader>gr",
--   "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
--   { noremap = true, silent = true, desc = "Reset Hunk" }
-- )
--
-- -- diff
-- map("n", "<leader>ds", "<cmd>windo diffthis<cr>", { desc = "Diff Split" })
--
-- -- escape
-- map("i", "jk", "<ESC>:w<CR>", opts)
--
-- -- buffers
-- map("n", "X", ":bdelete!<CR>", opts)
-- map("n", "L", ":bnext<CR>", opts)
-- map("n", "H", ":bprev<CR>", opts)
-- map("n", "gl", vim.diagnostic.open_float, opts)
-- map("n", ";p", '"0p', opts)
-- map("n", ";c", '"_c', opts)
-- map("n", ";d", '"_d', opts)
-- map("n", "<esc>", ":set hlsearch!<CR>")
--
-- -- code
-- map("n", "<leader>uv", function()
--   -- local new_config = not vim.diagnostic.config().virtual_text
--   -- vim.diagnostic.config({ virtual_text = new_config })
--   require("tiny-inline-diagnostic").toggle()
-- end, { desc = "Toggle diagnostic virtual_lines" })
-- map("n", "gA", vim.lsp.codelens.run, opts)
-- map(
--   "n",
--   "gv",
--   "<cmd>vsplit | lua vim.lsp.buf.definition({on_list = function(items) vim.fn.setqflist({}, 'r', items) vim.cmd('cfirst') end})<cr>",
--   opts
-- )
-- map("n", "ga", function()
--   require("tiny-code-action").code_action()
-- end, opts)
-- map("n", "<leader>st", LazyVim.pick("live_grep"), opts)
-- map("n", "<leader>sT", "<cmd>TodoTelescope<cr>", opts)
-- map("n", "<leader>cs", "<cmd>Outline<cr>", opts)
-- map("n", "<c-`>", function()
--   Snacks.terminal()
-- end, { desc = "Toggle Terminal" })
--
-- -- window resizing
-- map("n", "<A-Up>", ":resize +2<CR>", opts)
-- map("n", "<A-Down>", ":resize -2<CR>", opts)
-- map("n", "<A-Left>", ":vertical resize +2<CR>", opts)
-- map("n", "<A-Right>", ":vertical resize -2<CR>", opts)
--
-- map("n", "<CR>", function()
--   local cur_win = vim.api.nvim_get_current_win()
--   local buf = vim.api.nvim_win_get_buf(cur_win)
--
--   if vim.bo[buf].buftype ~= "quickfix" then
--     vim.api.nvim_set_var("non_float_total", 0)
--     vim.cmd("silent! windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
--     vim.api.nvim_set_current_win(cur_win or 0)
--     if vim.api.nvim_get_var("non_float_total") == 1 then
--       if vim.fn.tabpagenr("$") == 1 then
--         return
--       end
--       vim.cmd("tabclose")
--     else
--       local last_cursor = vim.api.nvim_win_get_cursor(0)
--       pcall(vim.cmd, "tabedit %:p")
--       vim.api.nvim_win_set_cursor(0, last_cursor)
--     end
--     return
--   end
--
--   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'nt')
--
-- end, opts)
--
-- require("which-key").add({
--   { "<leader>a", group = "Avante", icon = " " },
-- })
