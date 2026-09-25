require('lazy').setup {
  { 'NMAC427/guess-indent.nvim', opts = {} }, -- Detect tabstop and shiftwidth automatically
  -- { 'windwp/nvim-autopairs', opts = {} },
  require 'plugins/treesitter',
  require 'plugins/which-key',
  require 'plugins/telescope',
  require 'plugins/mini',
  require 'plugins/gitsigns',
  require 'plugins/lspconfig',
  require 'plugins/lint',
  require 'plugins/conform',
  -- require 'plugins/cmp', -- alternative to blink
  require 'plugins/blink-cmp',
  require 'plugins/colorthemes',
  { 'folke/todo-comments.nvim', opts = { signs = false } }, -- Highlight todo, notes, etc in comments
  { 'catgoose/nvim-colorizer.lua', opts = {} },
  require 'plugins/oil',
  require 'plugins/vim-tmux-navigator',
  require 'plugins/dap',
  -- require("plugins/quarto"),
  -- require 'plugins/slime',
}
-- vim: ts=2 sts=2 sw=2 et
