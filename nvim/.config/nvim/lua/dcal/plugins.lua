local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- use 'dense-analysis/ale'

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
