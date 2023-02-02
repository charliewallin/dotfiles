local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Initialize packer
require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
--  display = {
--    open_fn = function()
--      return require('packer.util').float({ border = 'solid' })
--    end,
--  },
})

local use = require('packer').use

-- Packer can manage itself
use('wbthomason/packer.nvim')

-- Commenting support
use('tpope/vim-commentary')

-- Navigate seamlessly through windows and tmux panes
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when using a file
use('farmergreg/vim-lastplace')

-- Add, change, and delete surrounding text
use('tpope/vim-surround')

-- Adds :Rename, :SudoWrite
use('tpope/vim-eunuch')

-- Adds [b ]b and other handy mappings
use('tpope/vim-unimpaired') 

-- Add more languages
use('sheerun/vim-polyglot') 

-- Indent autodetection with editorconfig support
use('tpope/vim-sleuth') 

-- Automatically create parent dirs when saving
use('jessarcher/vim-heritage') 

-- Automatically set up your configuration after cloning packer.nvim
use('nelstrom/vim-visual-star-search')

use({
  'tpope/vim-projectionist',
  requires = 'tpope/vim-dispatch',
  config = function()
    require('user.plugins.projectionist')
  end,
})

-- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])


