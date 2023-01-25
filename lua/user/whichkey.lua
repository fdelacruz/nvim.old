local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<Space>"] = "SPC",
    -- ["<CR>"] = "RET",
    -- ["<Tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<C-d>", -- binding to scroll down inside the popup
    scroll_up = "<C-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<Cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local m_opts = {
  mode = "n", -- NORMAL mode
  prefix = "m",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local m_mappings = {
  a = { "<Cmd>silent BookmarkAnnotate<CR>", "Annotate" },
  b = { "<Cmd>silent BookmarkToggle<CR>", "Toggle" },
  c = { "<Cmd>silent BookmarkClear<CR>", "Clear" },
  m = { '<Cmd>lua require("harpoon.mark").add_file()<CR>', "Harpoon" },
  ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<CR>', "Harpoon Next" },
  [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Harpoon Prev" },
  j = { "<Cmd>silent BookmarkNext<CR>", "Next" },
  s = { "<Cmd>Telescope harpoon marks<CR>", "Search Files" },
  k = { "<Cmd>silent BookmarkPrev<CR>", "Prev" },
  S = { "<Cmd>silent BookmarkShowAll<CR>", "Show All" },
  x = { "<Cmd>BookmarkClearAll<CR>", "Clear All" },
  [";"] = { '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Harpoon UI" },
}

local mappings = {
  a = { "<Cmd>Alpha<CR>", "Alpha" },
  b = {
    "<Cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<CR>",
    "Buffers",
  },
  e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
  w = { "<Cmd>w<CR>", "Write" },
  -- h = { "<cmd>nohlsearch<CR>", "No HL" },
  q = { '<Cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
  ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
  c = { "<Cmd>Bdelete!<CR>", "Close Buffer" },
  P = { "<Cmd>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
  -- ["R"] = { '<cmd>lua require("renamer").rename()<CR>', "Rename" },
  z = { "<Cmd>ZenMode<CR>", "Zen" },
  gy = "Link",

  B = {
    name = "Browse",
    i = { "<Cmd>BrowseInputSearch<CR>", "Input Search" },
    b = { "<Cmd>Browse<CR>", "Browse" },
    d = { "<Cmd>BrowseDevdocsSearch<CR>", "Devdocs" },
    f = { "<Cmd>BrowseDevdocsFiletypeSearch<CR>", "Devdocs Filetype" },
    m = { "<Cmd>BrowseMdnSearch<CR>", "Mdn" },
  },

  p = {
    name = "Lazy",
    -- c = { "<Cmd>PackerCompile<CR>", "Compile" },
    i = { "<Cmd>Lazy install<CR>", "Install" },
    s = { "<Cmd>Lazy sync<CR>", "Sync" },
    S = { "<Cmd>Lazy show<CR>", "Status" },
    u = { "<Cmd>Lazy update<CR>", "Update" },
  },

  o = {
    name = "Options",
    c = { '<cmd>lua vim.g.cmp_active=false<cr>', "Completion off" },
    C = { '<cmd>lua vim.g.cmp_active=true<cr>', "Completion on" },
    w = { '<Cmd>lua require("user.functions").toggle_option("wrap")<CR>', "Wrap" },
    r = { '<Cmd>lua require("user.functions").toggle_option("relativenumber")<CR>', "Relative" },
    l = { '<Cmd>lua require("user.functions").toggle_option("cursorline")<CR>', "Cursorline" },
    s = { '<Cmd>lua require("user.functions").toggle_option("spell")<CR>', "Spell" },
    t = { '<Cmd>lua require("user.functions").toggle_tabline()<CR>', "Tabline" },
  },

  s = {
    name = "Session",
    s = { "<Cmd>SaveSession<CR>", "Save" },
    r = { "<Cmd>RestoreSession<CR>", "Restore" },
    x = { "<Cmd>DeleteSession<CR>", "Delete" },
    f = { "<Cmd>Autosession search<CR>", "Find" },
    d = { "<Cmd>Autosession delete<CR>", "Find Delete" },
    -- a = { ":SaveSession<CR>", "test" },
    -- a = { ":RestoreSession<CR>", "test" },
    -- a = { ":RestoreSessionFromFile<CR>", "test" },
    -- a = { ":DeleteSession<CR>", "test" },
  },

  r = {
    name = "Replace",
    r = { "<Cmd>lua require('spectre').open()<CR>", "Replace" },
    w = { "<Cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word" },
    f = { "<Cmd>lua require('spectre').open_file_search()<CR>", "Replace Buffer" },
  },

  d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },

  f = {
    name = "Find",
    b = { "<Cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<Cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<Cmd>Telescope find_files<CR>", "Find files" },
    t = { "<Cmd>Telescope live_grep<CR>", "Find Text" },
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    H = { "<Cmd>Telescope highlights<CR>", "Highlights" },
    i = { "<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>", "Media" },
    l = { "<Cmd>Telescope resume<CR>", "Last Search" },
    M = { "<Cmd>Telescope man_pages<CR>", "Man Pages" },
    o = { "<Cmd>Telescope oldfiles<CR>", "Recent Files" },
    r = { "<Cmd>Telescope registers<CR>", "Registers" },
    k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<Cmd>Telescope commands<CR>", "Commands" },
  },

  g = {
    name = "Git",
    g = { "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<Cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<Cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    l = { "<Cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
    p = { "<Cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    r = { "<Cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<Cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<Cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      "<Cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { "<Cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<Cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<Cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<Cmd>Gitsigns diffthis HEAD<CR>",
      "Diff",
    },
    G = {
      name = "Gist",
      a = { "<Cmd>Gist -b -a<CR>", "Create Anon" },
      d = { "<Cmd>Gist -d<CR>", "Delete" },
      f = { "<Cmd>Gist -f<CR>", "Fork" },
      g = { "<Cmd>Gist -b<CR>", "Create" },
      l = { "<Cmd>Gist -l<CR>", "List" },
      p = { "<Cmd>Gist -b -p<CR>", "Create Private" },
    },
  },

  l = {
    name = "LSP",
    a = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    c = { "<Cmd>lua require('user.lsp').server_capabilities()<CR>", "Get Capabilities" },
    d = { "<Cmd>TroubleToggle<CR>", "Diagnostics" },
    w = {
      "<Cmd>Telescope lsp_workspace_diagnostics<CR>",
      "Workspace Diagnostics",
    },
    f = { "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
    F = { "<Cmd>LspToggleAutoFormat<CR>", "Toggle Autoformat" },
    i = { "<Cmd>LspInfo<CR>", "Info" },
    h = { "<Cmd>lua require('lsp-inlayhints').toggle()<CR>", "Toggle Hints" },
    H = { "<Cmd>IlluminationToggle<CR>", "Toggle Doc HL" },
    I = { "<Cmd>LspInstallInfo<CR>", "Installer Info" },
    j = {
      "<Cmd>lua vim.diagnostic.goto_next(buffer=0)<CR>",
      "Next Diagnostic",
    },
    k = {
      "<Cmd>lua vim.diagnostic.goto_prev(buffer=0)<CR>",
      "Prev Diagnostic",
    },
    l = { "<Cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    o = { "<Cmd>SymbolsOutline<CR>", "Outline" },
    q = { "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    r = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    R = { "<Cmd>TroubleToggle lsp_references<CR>", "References" },
    s = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
    t = { '<Cmd>lua require("user.functions").toggle_diagnostics()<CR>', "Toggle Diagnostics" },
  },

  S = {
    -- name = "Session",
    -- s = { "<Cmd>SaveSession<CR>", "Save" },
    -- l = { "<Cmd>LoadLastSession!<CR>", "Load Last" },
    -- d = { "<Cmd>LoadCurrentDirSession!<CR>", "Load Last Dir" },
    -- f = { "<Cmd>Telescope sessions save_current=false<CR>", "Find Session" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<CR>", "1" },
    ["2"] = { ":2ToggleTerm<CR>", "2" },
    ["3"] = { ":3ToggleTerm<CR>", "3" },
    ["4"] = { ":4ToggleTerm<CR>", "4" },
    n = { "<Cmd>lua _NODE_TOGGLE()<CR>", "Node" },
    u = { "<Cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
    t = { "<Cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
    p = { "<Cmd>lua _PYTHON_TOGGLE()<CR>", "Python3" },
    i = { "<Cmd>lua _IPYTHON_TOGGLE()<CR>", "iPython3" },
    f = { "<Cmd>ToggleTerm direction=float<CR>", "Float" },
    h = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<Cmd>TSHighlightCapturesUnderCursor<CR>", "Highlight" },
    p = { "<Cmd>TSPlaygroundToggle<CR>", "Playground" },
    r = { "<Cmd>TSToggle rainbow<CR>", "Rainbow" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
  ["/"] = { '<Esc><Cmd>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(m_mappings, m_opts)
