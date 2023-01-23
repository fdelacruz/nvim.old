return {
  "nvim-lua/plenary.nvim",
  "windwp/nvim-autopairs",
  { "numToStr/Comment.nvim",
    keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true
  },
  "moll/vim-bbye",
  "nvim-lualine/lualine.nvim",
  { "akinsho/toggleterm.nvim", event = "VeryLazy" },
  "ahmedkhalf/project.nvim",
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  {
    "unblevable/quick-scope",
    lazy = false,
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },
  "phaazon/hop.nvim",

  -- Lua
  {
    "abecodes/tabout.nvim",
    dependencies = "nvim-treesitter",
  },
  "nacro90/numb.nvim",
  -- use "norcalli/nvim-colorizer.lua"
  "NvChad/nvim-colorizer.lua",
  "windwp/nvim-spectre",
  "kevinhwang91/nvim-bqf",
  -- use "ThePrimeagen/harpoon",
  "christianchiarulli/harpoon",
  "MattesGroeger/vim-bookmarks",
  "kylechui/nvim-surround",
  "tpope/vim-repeat",
  "metakirby5/codi.vim",
  { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" },
  "matbme/JABS.nvim",
  -- "aserowy/tmux.nvim",
  { "rmagatti/auto-session", branch = "dir-changed-fixes" },
  "rmagatti/session-lens",

  --UI
  { "stevearc/dressing.nvim", event = "VeryLazy"},
  "ghillb/cybu.nvim",
  -- "SmiteshP/nvim-gps",
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },
  "tversteeg/registers.nvim",
  "rcarriga/nvim-notify",
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
  --"tamago324/lir.nvim",
  "christianchiarulli/lir.nvim",
  "goolord/alpha-nvim",
  { "folke/which-key.nvim", event = "VeryLazy" },
  "folke/zen-mode.nvim",
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end
  },
  { "karb94/neoscroll.nvim",
    keys = { { "<C-u>" }, { "<C-d>" }, { "<C-b>" }, { "<C-f>" }, { "<C-y>" }, { "<C-e>" }, { "zt" }, { "zz" },{  "zb" } },
    config = true
  },
  "folke/todo-comments.nvim",
  "andymass/vim-matchup",
  "is0n/jaq-nvim",
  "junegunn/vim-slash",

  -- Colorschemes
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd([[colorscheme kanagawa]])
    end
  },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-nvim-lua"
    },
  }, -- The completion plugin
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lua",
  {
    "tzachar/cmp-tabnine", commit = "1a8fd2795e4317fd564da269cc64a2fa17ee854e",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
  },

  -- snippets
  { "L3MON4D3/LuaSnip", dependencies = "friendly-snippets" },
  "rafamadriz/friendly-snippets",

  -- LSP
  { "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    }
  },
  -- "williamboman/nvim-lsp-installer",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "simrat39/symbols-outline.nvim",
  "ray-x/lsp_signature.nvim",
  "b0o/SchemaStore.nvim",
  "folke/trouble.nvim",
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  "j-hui/fidget.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  -- "simrat39/inlay-hints.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  -- Rust
  -- "simrat39/rust-tools.nvim",
  "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite",
  "Saecki/crates.nvim",

  -- Lua
  "christianchiarulli/lua-dev.nvim",

  -- Telescope
  "nvim-telescope/telescope.nvim",
  "tom-anders/telescope-vim-bookmarks.nvim",
  "nvim-telescope/telescope-media-files.nvim",
  "lalitmee/browse.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- build = ":TSUpdate",
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
  "p00f/nvim-ts-rainbow",
  "romgrk/nvim-treesitter-context",
  "drybalka/tree-climber.nvim",

  -- Git
  { "lewis6991/gitsigns.nvim", event = "BufRead" },
  "ruifm/gitlinker.nvim",
  "mattn/vim-gist",
  "mattn/webapi-vim",
  "rhysd/conflict-marker.vim",

  -- DAP
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",

  "nvim-telescope/telescope-dap.nvim",
}
