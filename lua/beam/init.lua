local builtin = require("beam.builtin")
local start_screen = require("beam.start_screen")
local M = {}
M.builtin = require("beam.builtin")

M.setup = function(user_opts)
    require("beam.conf").set(user_opts)
    local config = require("beam.conf").values
    local layout = l or require("layout.default_layout")
    if vim.fn.argc() == 0 then
        vim.cmd.cd(vim.fn.expand(config.repos_dir))
        start_screen.construct_beam_buf()
        start_screen.display_layout(layout)
    end
end

return M
