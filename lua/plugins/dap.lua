return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'igorlfs/nvim-dap-view',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local mason_dap = require 'mason-nvim-dap'
      local dap = require 'dap'
      local ui = require 'dap-view'
      local dap_virtual_text = require 'nvim-dap-virtual-text'

      dap_virtual_text.setup {}

      mason_dap.setup {
        ensure_installed = { 'cppdbg', 'python' },
        automatic_installation = false,
        handlers = {},
      }

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', 'gb', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })
      -- vim.keymap.set('n', '<leader>?', function()
      --   require('dapui').eval(nil, { enter = true })
      -- end)
      vim.keymap.set('n', '<leader>cr', dap.continue, { desc = 'Run / Continue' })
      vim.keymap.set('n', '<Left>', dap.step_out)
      vim.keymap.set('n', '<Right>', dap.step_into)
      vim.keymap.set('n', '<Down>', dap.step_over)
      vim.keymap.set('n', '<Up>', dap.restart_frame)
      -- vim.keymap.set('n', '<Up>', dap.step_back)
      vim.keymap.set('n', '<leader>cc', function()
        dap.terminate()
        ui.close(true)
        vim.defer_fn(dap_virtual_text.refresh, 30)
      end, { desc = '[C]ode [C]ancel' })

      vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
      vim.fn.sign_define('DapStopped', { text = '⮕' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '⚠️' })

      ui.setup {
        windows = {
          terminal = { hide = { 'cppdbg' } },
          -- height = 0.33,
        },
        winbar = {
          sections = { 'console', 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl' },
        },
      }
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
