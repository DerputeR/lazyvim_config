return {
    "mfussenegger/nvim-lint",
    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft

        -- Override try_lint to skip read-only files
        local orig_try_lint = lint.try_lint
        ---@diagnostic disable-next-line: duplicate-set-field
        lint.try_lint = function(ft)
            local bufnr = vim.api.nvim_get_current_buf()
            if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
                return
            end
            orig_try_lint(ft)
        end
    end,
}
