return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- Make sure to install via mason / npm
        markdown = { 'markdownlint' },
        -- python = { 'ruff' },
      }
      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then lint.try_lint() end
        end,
      })

      local lint_diagnostics_enabled = true

      local function get_configured_linter_names()
        local names = {}

        for _, linters in pairs(lint.linters_by_ft) do
          for _, linter_name in ipairs(linters) do
            names[linter_name] = true
          end
        end

        return vim.tbl_keys(names)
      end

      vim.keymap.set('n', '<leader>tl', function()
        lint_diagnostics_enabled = not lint_diagnostics_enabled

        for _, linter_name in ipairs(get_configured_linter_names()) do
          local namespace = lint.get_namespace(linter_name)

          if lint_diagnostics_enabled then
            vim.diagnostic.show(namespace, 0)
          else
            vim.diagnostic.hide(namespace, 0)
          end
        end

        vim.notify('nvim-lint diagnostics ' .. (lint_diagnostics_enabled and 'enabled' or 'disabled'), vim.log.levels.INFO)
      end, {
        desc = '[t]oggle [l]inter diagnostics',
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
