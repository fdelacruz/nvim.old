local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

hop.setup()

local keymap = vim.api.nvim_set_keymap

keymap("", "s", ":HopChar1<CR>", { silent = true })
keymap("", "S", ":HopWord<CR>", { silent = true })
