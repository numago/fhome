return {
  -- Enable cross navigation between vim splits and tmux panes
  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "Navigate to the Left Pane" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "Navigate to the Bottom Pane" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "Navigate to the Upper Pane" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Navigate to the Right Pane" },
      { "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", desc = "Navigate to the Last Active Pane" },
      { "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", desc = "Navigate to the Next Pane" },
    },
    opts = {
      disable_when_zoomed = false, -- defaults to false
    },
    config = true,
  },
}
