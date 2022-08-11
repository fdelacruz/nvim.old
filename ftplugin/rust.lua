local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Rust",
    h = { "<cmd>RustToggleInlayHints<CR>", "Toggle Hints" },
    r = { "<cmd>RustRunnables<CR>", "Runnables" },
    -- r = { "<cmd>lua _CARGO_RUN()<CR>", "Cargo Run" },
    t = { "<cmd>lua _CARGO_TEST()<CR>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
    p = { "<cmd>RustParentModule<CR>", "Parent Module" },
    -- j = { "<cmd>RustJoinLines<CR>", "Join Lines" },
    -- s = { "<cmd>RustStartStandaloneServerForBuffer<CR>", "Start Server Buf" },
    d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<CR>", "View Crate Graph" },
    R = {
      "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<CR>",
      "Reload Workspace",
    },
    -- S = { "<cmd>RustSSR<CR>", "SSR" },
    -- o = { "<cmd>RustOpenExternalDocs<CR>", "Open External Docs" },
    -- h = { "<cmd>RustSetInlayHints<CR>", "Enable Hints" },
    -- H = { "<cmd>RustDisableInlayHints<CR>", "Disable Hints" },
    -- a = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
    -- a = { "<cmd>RustHoverRange<CR>", "Hover Range" },
    -- j = { "<cmd>RustMoveItemDown<CR>", "Move Item Down" },
    -- k = { "<cmd>RustMoveItemUp<CR>", "Move Item Up" },
  },
}

which_key.register(mappings, opts)

local notify_filter = vim.notify
vim.notify = function(msg, ...)
  if msg:match "message with no corresponding" then
    return
  end

  notify_filter(msg, ...)
end


local Terminal = require("toggleterm.terminal").Terminal
local vertical_term = Terminal:new {
  cmd = "cargo run",
  direction = "vertical",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<M-4>",
      "<cmd>4ToggleTerm size=60 direction=vertical<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<m-4>",
      "<cmd>4ToggleTerm size=60 direction=vertical<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<M-4>",
      "<cmd>4ToggleTerm size=60 direction=vertical<CR>",
      { noremap = true, silent = true }
    )
  end,
  count = 4,
}

function _CARGO_TERM()
  vertical_term:toggle(60)
end

vim.api.nvim_set_keymap("n", "<M-4>", "<cmd>lua _CARGO_TERM()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<M-4>", "<cmd>lua _CARGO_TERM()<CR>", { noremap = true, silent = true })
