local layout = require("layout.default_layout")
local M = {}

function construct_beam_buf() -- void -> void
    vim.opt_local.bufhidden = 'wipe'
    vim.opt_local.buflisted = false
    vim.opt_local.swapfile = false
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.filetype = 'beam'
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
end

function display_layout(layout) -- tbl(layout) ->
    vim.api.nvim_buf_set_option(0, "modifiable", true)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {""})
    line_count = 0
    for _, elem in ipairs(layout) do
        vim.api.nvim_buf_set_lines(0, line_count, -1, false, elem.text)
        for idx, color in ipairs(elem.hl_tbl) do
            vim.api.nvim_buf_add_highlight(
                0, -1,
                color.color,
                (line_count + idx) - 1,
                color.start,
                color.stop
            )

        end
        line_count = line_count + #elem.text
    end
    vim.api.nvim_buf_set_option(0, "modifiable", false)
end

M.builtin = {
    switch_project = function()
        local project = vim.fn.expand("<cfile>")
        vim.cmd.cd(project)
        vim.cmd.edit(project)
    end,
    l = layout
}

M.setup = function()
    if vim.fn.argc() == 0 then
        vim.cmd.cd(vim.fn.expand("~/repos"))
        construct_beam_buf()
        display_layout(layout)
    end
end

return M
