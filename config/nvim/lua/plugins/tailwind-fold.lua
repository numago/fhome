return {
  {
    "razak17/tailwind-fold.nvim",
    opts = {
      highlight = {
        fg = "#ffc777",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>ut", "<Cmd>TailwindFoldToggle<CR>", desc = "Toggle Tailwind Fold" },
    },
  },
}
