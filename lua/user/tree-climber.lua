local status_ok, tree_climber = pcall(require, "tree-climber")
if not status_ok then
	return
end

local keyopts = { noremap = true, silent = true }
-- vim.keymap.set({'n', 'v', 'o'}, '<M-k>', tree_climber.goto_parent, keyopts)
-- vim.keymap.set({'n', 'v', 'o'}, '<M-j>', tree_climber.goto_child, keyopts)
vim.keymap.set({'n', 'v', 'o'}, '<M-j>', tree_climber.goto_next, keyopts)
vim.keymap.set({'n', 'v', 'o'}, '<M-k>', tree_climber.goto_prev, keyopts)
vim.keymap.set('n', '<M-h>', tree_climber.swap_prev, keyopts)
vim.keymap.set('n', '<M-l>', tree_climber.swap_next, keyopts)
