return {

  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    'jpalardy/vim-slime',
    dev = false,
    init = function()
      vim.g.slime_target = 'tmux' --"neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print('job_id: ' .. job_id)
      end

      local function set_terminal() vim.fn.call('slime#config', {}) end
      vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[c]ode [m]ark terminal' })
      vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[c]ode [s]et terminal' })

      vim.keymap.set('v', '<leader><CR>', ":<C-u>'<,'>SlimeSend<CR>", { desc = 'run selection' })
      vim.keymap.set('n', '<leader><CR>', '<Cmd>SlimeSendCurrentLine<CR>', { desc = 'run selection' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
