local M = {}
M.switch_project = function()
    local project = vim.fn.expand("<cfile>")
    vim.cmd.cd(project)
    vim.cmd.edit(project)
end

-- must recieve full path
M.get_repos = function(repo_dir) -- str(path) 
    local files = {}
    for _, file in ipairs(vim.fn.finddir(".git", repo_dir .. "**", -1)) do
        files[#files+1] = vim.fn.fnamemodify(file, ":p:h:h")
    end
    return files
end

return M
