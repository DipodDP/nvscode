local map = vim.keymap.set
local term = require("snacks.terminal")
local lazygit = require("snacks.lazygit")
local opts = { noremap = true, silent = true }

-- run last ran command
map("n", "<leader>ol", "<cmd>OverseerRestartLast<cr>", { desc = "Overseer Run Last" })

-- comment line
map("n", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })
map("v", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })

-- quick clear highlighting
map("n", "<C-[>", "<cmd>nohlsearch<cr>", opts)

-- next quickfix item
map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- better redo
map("n", "U", "<c-r>", { noremap = true, silent = true, desc = "redo" })

-- quick window quit
map("n", "<leader>qw", ":q<cr>", { noremap = true, silent = true, desc = "quit window" })

-- leader backspace to delete buffer
map("n", "<leader><bs>", ":bd<cr>", { noremap = true, silent = true, desc = "delete buffer" })

-- resume telescope after exiting
map("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>")

-- move line up and down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- floating terminal
map("n", "<c-/>", function()
  term.toggle()
end, { desc = "Terminal (root dir)" })

-- git
map("n", "<leader>gg", function()
  lazygit.open()
end, { desc = "Lazygit (root dir)" })
map(
  "n",
  "<leader>gj",
  "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>",
  { noremap = true, silent = true, desc = "Next Hunk" }
)
map(
  "n",
  "<leader>gk",
  "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>",
  { noremap = true, silent = true, desc = "Prev Hunk" }
)
map(
  "n",
  "<leader>gr",
  "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
  { noremap = true, silent = true, desc = "Reset Hunk" }
)

-- diff
map("n", "<leader>ds", "<cmd>windo diffthis<cr>", { desc = "Diff Split" })

-- escape
map("i", "jk", "<ESC>:w<CR>", opts)

-- buffers
map("n", "X", ":bdelete!<CR>", opts)
map("n", "L", ":bnext<CR>", opts)
map("n", "H", ":bprev<CR>", opts)
map("n", "gl", vim.diagnostic.open_float, opts)
map("n", ";p", '"0P', opts) -- Paste last yanked
map("n", "<esc>", ":set hlsearch!<CR>") -- Toggle search highlight

-- code
map("n", "<leader>uv", function()
  -- local new_config = not vim.diagnostic.config().virtual_text
  -- vim.diagnostic.config({ virtual_text = new_config })
  require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle diagnostic virtual_lines" })
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
map("n", "<leader>sT", "<cmd>TodoTelescope<cr>", opts)
map("n", "<leader>cs", "<cmd>Outline<cr>", opts)
map("n", "<c-`>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

-- window resizing
map("n", "<A-Up>", ":resize +2<CR>", opts)
map("n", "<A-Down>", ":resize -2<CR>", opts)
map("n", "<A-Left>", ":vertical resize +2<CR>", opts)
map("n", "<A-Right>", ":vertical resize -2<CR>", opts)

map("n", "<CR>", function()
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_var("non_float_total", 0)
  vim.cmd("windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
  vim.api.nvim_set_current_win(cur_win or 0)
  if vim.api.nvim_get_var("non_float_total") == 1 then
    if vim.fn.tabpagenr("$") == 1 then
      return
    end
    vim.cmd("tabclose")
  else
    local last_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd("tabedit %:p")
    vim.api.nvim_win_set_cursor(0, last_cursor)
  end
end, { noremap = true, silent = true, nowait = true })

require("which-key").add({
  { "<leader>a", group = "Avante", icon = " " },
})
