require("lazy").setup({
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  require("plugins/treesitter"),
  -- require("plugins/which-key"),
  require("plugins/telescope"),
  require("plugins/mini"),
  require("plugins/gitsigns"),
  require("plugins/lspconfig"),
  require("plugins/conform"),
  require("plugins/cmp"),
  require("plugins/colorthemes"),
  require("plugins/todo-comments"),
  require("plugins/colorizer"),
  -- require("plugins/autopairs"),
  -- require("plugins/neo-tree"),
  require("plugins/oil"),
  require("plugins/vim-tmux-navigator"),
  require("plugins/dap"),
  require("plugins/quarto"),
  require("plugins/slime"),
}, {
  ui = {
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
-- vim: ts=2 sts=2 sw=2 et
