return {

  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {},
    dependencies = {
      -- for language features in code cells
      -- configured in lua/plugins/lsp.lua and
      -- added as a nvim-cmp source in lua/plugins/completion.lua
      "jmbuhr/otter.nvim",
      "jpalardy/vim-slime",
    },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime", -- "molten", "slime", "iron" or <function>
          ft_runners = {},          -- filetype to runner, ie. `{ python = "molten" }`.
          -- Takes precedence over `default_method`
          never_run = { "yaml" },   -- filetypes which are never sent to a code runner
        },
      })

      vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { desc = "[Q]quarto [p]review" })
      vim.keymap.set("n", "<leader>qr", quarto.quartoSend, { desc = "[Q]quarto [r]un cell" })
      vim.keymap.set("n", "<leader>qa", quarto.activate, { desc = "[Q]quarto [a]ctivate" })

      -- { "<leader>qE", function() require('otter').export(true) end, desc = "[E]xport with overwrite" },
      -- { "<leader>qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
      -- { "<leader>qe", require('otter').export, desc = "[e]xport" },
      -- { "<leader>qh", ":QuartoHelp ", desc = "[h]elp" },
      -- { "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
      -- { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uit preview" },
      -- { "<leader>qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
      -- { "<leader>qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
      -- { "<leader>qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },

      --- Insert code chunk of given language
      --- Splits current chunk if already within a chunk
      --- @param lang string
      local insert_code_chunk = function(lang)
        local inside_code_chunk, _ = require("otter.keeper").get_current_language_context()
        local keys
        if inside_code_chunk then
          keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
        else
          keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
        end
        keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
        vim.api.nvim_feedkeys(keys, "n", false)
      end

      vim.keymap.set("n", "<leader>qc", function()
        insert_code_chunk("python")
      end, { desc = "[Q]quarto insert python [c]ode" })
    end,
  },

  -- { -- directly open ipynb files as quarto docuements
  -- 	-- and convert back behind the scenes
  -- 	"GCBallesteros/jupytext.nvim",
  -- 	opts = {
  -- 		custom_language_formatting = {
  -- 			python = {
  -- 				extension = "qmd",
  -- 				style = "quarto",
  -- 				force_ft = "quarto",
  -- 			},
  -- 			r = {
  -- 				extension = "qmd",
  -- 				style = "quarto",
  -- 				force_ft = "quarto",
  -- 			},
  -- 		},
  -- 	},
  -- },

  { -- paste an image from the clipboard or drag-and-drop
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
    opts = {
      default = {
        dir_path = "img",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("img-clip").setup(opts)
      vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "[i]nsert [i]mage from clipboard" })
    end,
  },

  { -- preview equations
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "[q]uarto toggle [m]ath equations" },
    },
  },

  {
    "benlubas/molten-nvim",
    enabled = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>",           desc = "[m]olten [i]nit" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "molten eval visual",
      },
      { "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
