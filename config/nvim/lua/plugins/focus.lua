return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        -- disable tmux statusline
        tmux = { enabled = true },
        -- enable to start Twilight when zen mode opens
        twilight = { enabled = false },
        gitsigns = { enabled = true },
        options = {
          -- disable neovim statusline
          -- laststatus = 2,
          showcmd = false,
          showmode = false,
        },
      },
    },
    config = function(_, opts)
      -- stylua: ignore
      vim.keymap.set("n", "go", function() require("zen-mode").toggle(opts) end, { desc = "Toggle zen mode" })

      -- opts.on_open = function(win)
      --   win.width = 80
      -- end
    end,
    event = "VeryLazy",
  },
  {
    "folke/twilight.nvim",
    enabled = true,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = "VeryLazy",
  },

  {
    "junegunn/goyo.vim",
    config = function()
      -- Create an augroup for Goyo custom settings
      vim.api.nvim_create_augroup("GoyoCustom", { clear = true })

      -- Define an autocmd for entering Goyo mode
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        group = "GoyoCustom",
        callback = function()
          if vim.g.goyo_active then
            return
          end
          vim.g.goyo_active = true

          -- Hide lualine
          require("lualine").hide({ unhide = false, place = { "statusline", "tabline", "winbar" } })

          -- Zoom in tmux pane
          if vim.fn.executable("tmux") == 1 and vim.fn.getenv("TMUX") ~= "" then
            vim.fn.system("tmux set status off")
            local pane_status = vim.fn.system("tmux list-panes -F '#F'")
            if not string.find(pane_status, "Z") then
              vim.fn.system("tmux resize-pane -Z")
            end
          end
          vim.opt.showmode = false
          vim.opt.showcmd = false
          vim.opt.scrolloff = 999

          -- Hide bufferline
          vim.cmd("BufferLineCloseRight")
          vim.cmd("BufferLineCloseLeft")

          -- Enable Limelight
          vim.cmd("Limelight")
        end,
      })

      -- Define an autocmd for leaving Goyo mode
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        group = "GoyoCustom",
        callback = function()
          if not vim.g.goyo_active then
            return
          end
          vim.g.goyo_active = false

          -- Show lualine
          require("lualine").hide({ unhide = true, place = { "statusline", "tabline", "winbar" } })

          -- Zoom out tmux pane
          if vim.fn.executable("tmux") == 1 and vim.fn.getenv("TMUX") ~= "" then
            vim.fn.system("tmux set status on")
            local pane_status = vim.fn.system("tmux list-panes -F '#F'")
            if string.find(pane_status, "Z") then
              vim.fn.system("tmux resize-pane -Z")
            end
          end
          vim.opt.showmode = true
          vim.opt.showcmd = true
          vim.opt.scrolloff = 5

          -- Show bufferline
          vim.cmd("BufferLineCycleNext")
          vim.cmd("BufferLineCyclePrev")

          -- Disable Limelight
          vim.cmd("Limelight!")
        end,
      })
    end,
    event = "VeryLazy",
  },
  {
    "junegunn/limelight.vim",
    event = "VeryLazy",
  },
}
