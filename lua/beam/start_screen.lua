local M = {}
M.construct_beam_buf = function() -- void -> void
    vim.opt_local.bufhidden = 'wipe'
    vim.opt_local.buflisted = false
    vim.opt_local.swapfile = false
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.filetype = 'beam'
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
end

M.display_layout = function(layout) -- tbl(layout) ->
    vim.api.nvim_buf_set_option(0, "modifiable", true)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {""})
    line_count = 0
    for _, elem in ipairs(layout) do
        vim.api.nvim_buf_set_lines(0, line_count, -1, false, elem.text)
        for idx, line in ipairs(elem.hl_tbl) do
            for _, color in ipairs(line) do
                vim.api.nvim_buf_add_highlight(
                    0, -1,
                    color.color,
                    (line_count + idx) - 1,
                    color.start,
                    color.stop
                )
            end
        end
        line_count = line_count + #elem.text
    end
    vim.api.nvim_buf_set_option(0, "modifiable", false)
end

return M
