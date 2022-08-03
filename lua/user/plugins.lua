local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  max_jobs = 50
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "unblevable/quick-scope"
  use "phaazon/hop.nvim"

  -- Lua
  use {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }
  use "nacro90/numb.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use "kevinhwang91/nvim-bqf"
  use "ThePrimeagen/harpoon"
  use "MattesGroeger/vim-bookmarks"
  use "kylechui/nvim-surround"
  use "tpope/vim-repeat"
  use "metakirby5/codi.vim"
  use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
  use "matbme/JABS.nvim"
  use "aserowy/tmux.nvim"
  use "rmagatti/auto-session"

  --UI
  use { "stevearc/dressing.nvim" }
  use "ghillb/cybu.nvim"
  use "SmiteshP/nvim-gps"
  use "tversteeg/registers.nvim"
  use "rcarriga/nvim-notify"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "tamago324/lir.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "folke/zen-mode.nvim"
  use "karb94/neoscroll.nvim"
  use "folke/todo-comments.nvim"
  use "andymass/vim-matchup"

  -- Colorschemes
  use "rebelot/kanagawa.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp-document-symbol" -- textDocument/documentSymbol completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim"
  use "folke/trouble.nvim"
  use "RRethy/vim-illuminate"
  use "j-hui/fidget.nvim"

  -- Rust
  use "simrat39/rust-tools.nvim"
  use "Saecki/crates.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "lalitmee/browse.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "romgrk/nvim-treesitter-context"
  use "drybalka/tree-climber.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"
  use "rhysd/conflict-marker.vim"

  -- Plugin Graveyard
  -- use "romgrk/nvim-treesitter-context"
  -- use "mizlan/iswap.nvim"
  -- use {'christianchiarulli/nvim-ts-rainbow'}
  -- use "nvim-telescope/telescope-ui-select.nvim"
  -- use "nvim-telescope/telescope-file-browser.nvim"
  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work
  -- use "filipdutescu/renamer.nvim"
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "Shatur/neovim-session-manager"
  -- use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  -- use "akinsho/bufferline.nvim"
  -- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
