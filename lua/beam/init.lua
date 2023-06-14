local builtin = require("beam.builtin")
local M = {}
M.builtin = require("beam.builtin")
M.conf = require("beam.conf")


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

M.configure = function(user_opts)
    require("beam.conf").set(user_opts)
end

M.setup = function()
    local conf = require("beam.conf")
    local layout = l or require("layout.default_layout")
    if vim.fn.argc() == 0 then
        vim.cmd.cd(vim.fn.expand(conf.repos_dir))
        construct_beam_buf()
        display_layout(layout)
    end
end

return M
