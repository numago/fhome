return {
  -- Adds support for remote development and devcontainers to Neovim
  {
    "amitds1997/remote-nvim.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },
  -- Add hostname to lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, function()
        return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.loop.os_gethostname()) or ""
      end)
    end,
  },
}
