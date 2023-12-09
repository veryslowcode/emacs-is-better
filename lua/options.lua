-- Tab with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Incremental search
vim.opt.incsearch = true

-- Ensure minimum lines shown
vim.opt.scrolloff = 10

-- Set linenumbers
vim.wo.number = true

-- Theme
vim.cmd.colorscheme "catppuccin"

-- Window split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Netrw
vim.g.netrw_banner = 0

-- Shell (Uncomment for using powershell)
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "powershell"
    vim.opt.shellquote = "\""
    vim.opt.shellxquote = ""
    vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
end
