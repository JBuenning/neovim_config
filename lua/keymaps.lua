-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "gq", vim.diagnostic.setloclist, { desc = "[g]oto [q]uickfix list" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "[L]SP: hover [d]iagnostic" })

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[t]oggle [d]iagnostics" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- move windows form insert or terminal mode
vim.keymap.set({ "i", "t" }, "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set({ "i", "t" }, "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set({ "i", "t" }, "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set({ "i", "t" }, "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Move focus to the upper window" })

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { desc = "Horizontal resize +}" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { desc = "Horizontal resize -}" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Vertical resize -}" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Vertical resize +}" })

-- keep selection after indent/dedent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- paste keeping the paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({ "v", "n" }, "<leader>d", "\"_d")

-- search replace word under cursor
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- [[ Autocommands ]]

-- Remember last cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    -- Use a small delay to ensure the file is fully loaded
    vim.defer_fn(function()
      local cursor = vim.api.nvim_win_get_cursor(0) -- Get current cursor position (line, column)
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)

      -- If the cursor is at the first line, restore the position
      if cursor[1] == 1 then
        if mark[1] > 0 and mark[1] <= lcount then
          pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
      end
    end, 50) -- Delay slightly to ensure file is loaded
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
