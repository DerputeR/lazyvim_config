local function get_node_at_cursor()
    local win = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(win)
    local row, col = cursor[1] - 1, cursor[2]

    if vim.api.nvim_get_mode().mode == "i" and col > 0 then
        col = col - 1
    end

    return vim.treesitter.get_node({ pos = { row, col } })
end

return {
    "saghen/blink.cmp",
    opts = {
        sources = {
            default = function()
                local node = get_node_at_cursor()
                if
                    node
                    and vim.tbl_contains(
                        { "comment", "line_comment", "block_comment", "comment_content", "string", "string_content" },
                        node:type()
                    )
                then
                    return {}
                end
                return { "lsp", "path", "snippets", "buffer" }
            end,
        },
    },
    opts_extend = { "sources.default" },
}
