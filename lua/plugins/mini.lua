return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        content = {
          active = function()
            local mode, mode_hl    = MiniStatusline.section_mode({ trunc_width = 120 })
            local git              = MiniStatusline.section_git({ trunc_width = 40 })
            -- local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
            -- local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            -- local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename         = MiniStatusline.section_filename({ trunc_width = 180 })
            local fileinfo         = MiniStatusline.section_fileinfo({ trunc_width = 250 }) --large trunc_width to disable extra text
            local location         = "%2l:%-2v"
            local location_percent = "%p%%"
            -- local search           = MiniStatusline.section_searchcount({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineDevinfo',  strings = { git } },
              { hl = 'MiniStatuslineFileinfo', strings = { location_percent } },
              { hl = mode_hl,                  strings = { location } },
            })
          end
        }
      })
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
