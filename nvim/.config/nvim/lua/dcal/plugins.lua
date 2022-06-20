_ = vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'dense-analysis/ale'

  use 'nvim-lua/plenary.nvim'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'nvim-treesitter/playground'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- TODO: try this out
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end
  }

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

  use 'morhetz/gruvbox'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dotenv'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'vim-test/vim-test'

  use { 'vim-ruby/vim-ruby', ft = 'ruby' }
  use { 'tpope/vim-rails', ft = 'ruby' }
end)
