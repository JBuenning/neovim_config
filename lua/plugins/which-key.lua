return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        -- { "<leader>c", group = "[C]ode",     mode = { "n", "x" } },
        -- { "<leader>d", group = "[D]ocument" },
        -- { "<leader>l", group = "[L]SP" },
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        -- { "<leader>w", group = "[W]orkspace" },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
