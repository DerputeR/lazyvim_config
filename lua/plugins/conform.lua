return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            cpp = { "clang-format" },
            c = { "clang-format" },
            cs = { "clang-format" },
            java = { "clang-format" },
            javascript = { "clang-format" },
        },
        formatters = {
            ["clang-format"] = {
                condition = function(_, ctx)
                    return vim.fs.find({ ".clang-format" }, { path = ctx.filename, upward = true })
                    -- local util = require("conform.util")
                    -- local root = util.root.get(ctx.buf)
                    -- return vim.uv.fs_stat(root .. "/.clang-format") ~= nil
                end,
                prepend_args = { "--style=file", "--fallback-style=LLVM" },
            },
        },
    },
    -- opts = function()
    --     local plugin = require("lazy.core.config").plugins["conform.nvim"]
    --     if plugin.config ~= M.setup then
    --         LazyVim.error({
    --             "Don't set `plugin.config` for `conform.nvim`.\n",
    --             "This will break **LazyVim** formatting.\n",
    --             "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
    --         }, { title = "LazyVim" })
    --     end
    --     ---@type conform.setupOpts
    --     local opts = {
    --         default_format_opts = {
    --             timeout_ms = 3000,
    --             async = false, -- not recommended to change
    --             quiet = false, -- not recommended to change
    --             lsp_format = "fallback", -- not recommended to change
    --         },
    --         formatters_by_ft = {
    --             lua = { "stylua" },
    --             fish = { "fish_indent" },
    --             sh = { "shfmt" },
    --         },
    --         -- The options you set here will be merged with the builtin formatters.
    --         -- You can also define any custom formatters here.
    --         ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    --         formatters = {
    --             clangd = {
    --                 condition = function(self, ctx)
    --                     local util = require("conform.util")
    --                     return util.root_has_file({ ".clang-format" })(ctx.buf)
    --                 end,
    --             },
    --         },
    --     }
    --     return opts
    -- end,
}
