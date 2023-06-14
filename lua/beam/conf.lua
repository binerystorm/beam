local M = {}
M.values = { }
M.set = function(user_opts)
    M.values = vim.tbl_deep_extend("force", M.values, user_opts or {repos_dir = "bla"})
end

M.set{repos_dir = "~/repos"}

return M
