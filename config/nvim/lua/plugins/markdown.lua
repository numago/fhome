return {
  -- Markup language table formatter
  {
    "dhruvasagar/vim-table-mode",
    config = function()
      vim.g.table_mode_color_cells = true
    end,
  },

  -- render preview in the browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function(_, opts)
      vim.g.mkdp_auto_close = 0
    end,
  },
}
