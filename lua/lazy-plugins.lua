require('lazy').setup {
  { 'NMAC427/guess-indent.nvim', opts = {} }, -- Detect tabstop and shiftwidth automatically
  require 'plugins/treesitter',
  require 'plugins/which-key',
  require 'plugins/telescope',
  require 'plugins/mini',
  require 'plugins/gitsigns',
  require 'plugins/lspconfig',
  require 'plugins/conform',
  -- require 'plugins/cmp',
  require 'plugins/blink-cmp',
  require 'plugins/colorthemes',
  require 'plugins/todo-comments',
  require 'plugins/colorizer',
  -- require("plugins/autopairs"),
  require 'plugins/oil',
  require 'plugins/vim-tmux-navigator',
  require 'plugins/dap',
  -- require("plugins/quarto"),
  require 'plugins/slime',
}
-- vim: ts=2 sts=2 sw=2 et
