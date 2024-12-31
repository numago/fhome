return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- Font: DOS Rebel
      local logo = [[
                         ███                 
                        ░░░                  
 ████████   █████ █████ ████  █████████████  
░░███░░███ ░░███ ░░███ ░░███ ░░███░░███░░███ 
 ░███ ░███  ░███  ░███  ░███  ░███ ░███ ░███ 
 ░███ ░███  ░░███ ███   ░███  ░███ ░███ ░███ 
 ████ █████  ░░█████    █████ █████░███ █████
░░░░ ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ 

      ]]
      logo = string.rep("\n", 6) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")

      -- opts.config.week_header = { enable = true, append = { "" } }

      opts.config.center = {
        {
          action = "lua LazyVim.pick()()",
          desc = " Find File",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New File",
          icon = " ",
          key = "n",
        },
        {
          action = 'lua LazyVim.pick("oldfiles")()',
          desc = " Recent Files",
          icon = " ",
          key = "r",
        },
        {
          action = 'lua LazyVim.pick("live_grep")()',
          desc = " Find Text",
          icon = " ",
          key = "g",
        },
        {
          action = "lua LazyVim.pick.config_files()()",
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = 'lua require("mini.sessions").read()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
  },
}
