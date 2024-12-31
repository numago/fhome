-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

return {
  -- Override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  -- Add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "svelte",
        "haskell",
        "vue",
      })
    end,
  },

  -- Use Comment.nvim instead of mini.comment because of lacking comment strings in mini.comment
  -- { "echasnovski/mini.comment", enabled = false },
  -- { "numToStr/Comment.nvim", config = true },

  -- add Mason tools to install by default
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "vue-language-server",
        "prettier",
        "html-lsp",
      },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "js",
      },
    },
  },

  -- {
  --   "echasnovski/mini.animate",
  --   opts = function(_, opts)
  --     opts.resize = { enable = false }
  --   end,
  -- },

  {
    "nvim-focus/focus.nvim",
  },

  {
    "echasnovski/mini.splitjoin",
    config = true,
    keys = {
      { "sG", "MiniSplitjoin.toggle()", desc = "Toggle split/join arguments" },
    },
  },

  {
    "echasnovski/mini.hipatterns",
    opts = function()
      local hi = require("mini.hipatterns")
      local Job = require("plenary.job")

      -- Function to extract custom colors from tailwind.config.js
      local function extract_tailwind_colors()
        local colors = {}

        local config_path = vim.fn.findfile("tailwind.config.js")
        if config_path == "" then
          return colors
        end

        -- Use plenary to read the config file
        local config_lines = Job:new({
          command = "node",
          args = {
            "-e",
            [[
        const fs = require('fs');
        const tailwindConfig = require('./tailwind.config.js');
        const colors = tailwindConfig.theme.extend.colors;
        console.log(JSON.stringify(colors));
      ]],
          },
          cwd = vim.fn.fnamemodify(config_path, ":h"),
        }):sync()

        if #config_lines > 0 then
          local success, parsed_colors = pcall(vim.fn.json_decode, table.concat(config_lines, ""))
          if success and parsed_colors then
            colors = parsed_colors
          end
        end

        return colors
      end

      local tailwind_colors = extract_tailwind_colors()

      -- Integrate custom colors into the highlighter setup
      local function generate_tailwind_highlighter(opts)
        local M = {}
        M.hl = {}
        M.colors = {}

        for name, color in pairs(tailwind_colors) do
          if type(color) == "table" then
            for shade, hex in pairs(color) do
              M.colors[name .. "-" .. shade] = hex
            end
          else
            M.colors[name] = color
          end
        end

        return {
          pattern = function()
            if not vim.tbl_contains(opts.tailwind.ft, vim.bo.filetype) then
              return
            end
            if opts.tailwind.style == "full" then
              return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
            elseif opts.tailwind.style == "compact" then
              return "%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]"
            end
          end,
          group = function(_, _, m)
            ---@type string
            local match = m.full_match
            local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
            local hex = tailwind_colors[color] and tailwind_colors[color][shade] or tailwind_colors[color]
            if hex then
              local hl = "MiniHipatternsTailwind" .. color .. (shade or "")
              if not M.hl[hl] then
                M.hl[hl] = true
                vim.api.nvim_set_hl(0, hl, { bg = hex, fg = "#000000" })
              end
              return hl
            end
          end,
          extmark_opts = { priority = 2000 },
        }
      end

      return {
        -- custom LazyVim option to enable the tailwind integration
        tailwind = {
          enabled = true,
          ft = {
            "astro",
            "css",
            "heex",
            "html",
            "html-eex",
            "javascript",
            "javascriptreact",
            "rust",
            "svelte",
            "typescript",
            "typescriptreact",
            "vue",
          },
          -- full: the whole css class will be highlighted
          -- compact: only the color will be highlighted
          style = "full",
        },
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
          shorthand = {
            pattern = "()#%x%x%x()%f[^%x%w]",
            group = function(_, _, data)
              ---@type string
              local match = data.full_match
              local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
              local hex_color = "#" .. r .. r .. g .. g .. b .. b

              return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
            end,
            extmark_opts = { priority = 2000 },
          },
          tailwind = generate_tailwind_highlighter({
            tailwind = {
              enabled = true,
              ft = {
                "astro",
                "css",
                "heex",
                "html",
                "html-eex",
                "javascript",
                "javascriptreact",
                "rust",
                "svelte",
                "typescript",
                "typescriptreact",
                "vue",
              },
              style = "full",
            },
          }),
        },
      }
    end,
  },
}
