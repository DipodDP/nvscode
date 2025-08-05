local map = vim.keymap.set
local opts = { silent = true, remap = true }

-- Search
map("n", "<LEADER>ff", '<CMD>call VSCodeNotify("workbench.action.quickOpen")<CR>')
map("n", "<LEADER>fw", '<CMD>call VSCodeNotify("workbench.action.findInFiles")<CR>')

-- Navigation
-- map("n", "j", '<CMD>call VSCodeNotify("cursorDown")<CR>', { desc = "Down", remap = true })
-- map({ "n", "x" }, "<C-j>", '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>', { desc = "Down", remap = true })
-- map({ "n", "x" }, "<C-k>", '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>', { desc = "Up", remap = true })
-- map({ "n", "x" }, "<C-h>", '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>', { desc = "Left", remap = true })
-- map({ "n", "x" }, "<C-l>", '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>', { desc = "Right", remap = true })
-- Navigation
-- map("n", "<C-j>", '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>')
-- map("x", "<C-j>", '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>')
-- map("n", "<C-k>", '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>')
-- map("x", "<C-k>", '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>')
-- map("n", "<C-h>", '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
-- map("x", "<C-h>", '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
-- map("n", "<C-l>", '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>')
-- map("x", "<C-l>", '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>')

-- Active editor
map("n", "<S-x>", '<CMD>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>', opts)
map("n", "]B", '<CMD>call VSCodeNotify("workbench.action.moveEditorRightInGroup")<CR>')
map("n", "[B", '<CMD>call VSCodeNotify("workbench.action.moveEditorLeftInGroup")<CR>')

-- Toggles sidebars
map("n", "<LEADER>e", '<CMD>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>')
map("n", "<LEADER>E", '<CMD>call VSCodeNotify("workbench.action.toggleAuxiliaryBar")<CR>')

-- Hover
map("n", "K", '<CMD>call VSCodeNotify("editor.action.showHover")<CR>')
map("n", "<LEADER>k", '<CMD>call VSCodeNotify("editor.action.showHover")<CR>')

-- VSCode definitions/references
map("n", "gd", '<CMD>call VSCodeNotify("editor.action.revealDefinition")<CR>')
map("n", "gr", '<CMD>call VSCodeNotify("editor.action.goToReferences")<CR>')

map("n", "gA", '<CMD>call VSCodeNotify("editor.action.goToReferences")<CR>')

-- better up/down
map({ "n", "v" }, "j", "gj", opts)
map({ "n", "v" }, "k", "gk", opts)
map({ "n", "v" }, "<Down>", "gj", opts)
map({ "n", "v" }, "<Up>", "gk", opts)
