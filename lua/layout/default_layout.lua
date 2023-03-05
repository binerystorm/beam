builtin = require("beam.builtin")
conf = require("beam.conf")
-- layout structure:
--   {
--     type,
--     text,
--     hl_tbl
--   } ...

-- must recieve full path
-- function get_repos(repo_dir) -- str(path) 
--     local files = {}
--     for _, file in ipairs(vim.fn.finddir(".git", repo_dir .. "**", -1)) do
--         files[#files+1] = vim.fn.fnamemodify(file, ":p:h:h")
--     end
--     return files
-- end

function init_link(file) --str(path)
    return {
        text = {"+ " .. file},
        hl_tbl = {
            {
                { start = 0, stop = 2, color = "Statement" }
            }
        }
    }
end

local repo_dir = vim.fn.expand(conf.repos_dir)
local title = {
    text = {
"    )                             ",
" ( /(                             ",
" )\\())   (        )   (      )    ",
"((_)\\   ))\\  (   /((  )\\    (     ",
" _((_) /((_) )\\ (_))\\((_)   )\\  ' ",
"| \\| |(_))  ((_)_)((_)(_) _((_))  ",
"| .` |/ -_)/ _ \\\\ V / | || '  \\() ",
"|_|\\_|\\___|\\___/ \\_/  |_||_|_|_|  ",
        -- "neovim",
        -- "======",
        ""
    },
    hl_tbl = {
        {{start = 0, stop = -1, color = "Statement"}},
        {{start = 0, stop = -1, color = "Statement"}},
        {{start = 0, stop = -1, color = "Statement"}},
        {{start = 0, stop = -1, color = "Statement"}},
        {{start = 0, stop = -1, color = "Statement"}},
        {
            {start = 0, stop = -1, color = "Statement"},
            {start = 0, stop = 6, color = "String"}
        },
        {
            {start = 0, stop = -1, color = "String"},
            {start = 31, stop = -1, color = "Statement"}
        },
        {{start = 0, stop = -1, color = "String"}}
    }
}

local header_repos = {
    text = {
        "Repos",
        "====="
    },
    hl_tbl = {
        {{start = 0, stop = -1, color = "String"}},
        {{start = 0, stop = -1, color = "Statement"}},
    }
}

local layout = {
    title,
    header_repos,
    unpack((function() 
        local list = {}
        for _, i in ipairs(builtin.get_repos(repo_dir)) do 
            list[#list + 1] = init_link(i)
        end 
        return list
    end)()),
}

return layout
