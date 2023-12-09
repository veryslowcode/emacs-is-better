-- Setup Catppuccin 
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
})

-- Setup Telescope
require('telescope').setup({
    defaults = {
        path_display = {
            "truncate"
        }
    }
})

-- Setup Alpha
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗",
    "████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║",
    "██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║",
    "██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║",
    "██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║",
    "╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝"
}

function getConfig()
    if vim.loop.os_uname().sysname == "Windows_NT" then
        return ":e ~/AppData/Local/nvim/<CR>"
    else
        return ":e ~/.config/nvim/<CR>"
    end
end

dashboard.section.buttons.val = {
    dashboard.button("n", "New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "Find file", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button("e", "File Explorer", ":cd $HOME | :Ex<CR>"),
    dashboard.button("r", "Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("c", "Configuration", getConfig()),
    dashboard.button("s", "Search", ":Telescope live_grep<CR>"),
    dashboard.button("q", "Quit", ":qa<CR>"),
    -- Additional buttons
}

local version = vim.version()
dashboard.section.footer.val = {
   "Vim, but better...",
   "Version " .. version.major .. "." .. version.minor .. "." .. version.patch
}

alpha.setup(dashboard.opts)
