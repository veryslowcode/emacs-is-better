-- Configure Packer & Add Plugins {{{
local require_packer = function()
	local api = vim.fn
	local path = api.stdpath("data").."/site/pack/packer/start/packer.nvim"

	if api.empty(api.glob(path)) > 0 then
		api.system({ "git", "clone", "--depth", "1",
		  "https://github.com/wbthomason/packer.nvim",
	           path})

		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local bootstrap = require_packer()
require("packer").startup(function(use)
    -- Package manager
	use "wbthomason/packer.nvim"
    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        }
    }
    -- Language tools
    use "numToStr/Comment.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
        }
    }
	-- Search & Fuzzy find
	use {
        "nvim-telescope/telescope.nvim",
	    requires = {
            "nvim-lua/plenary.nvim"
        }
    }
	-- Theme
	use {
        "catppuccin/nvim", 
        as = "catppuccin"
    }
	-- Dashboard/Greeter
	use "goolord/alpha-nvim"
    -- Status line
    use "nvim-lualine/lualine.nvim"
	-- Automatically sync plugins
	if bootstrap then
		require("packer").sync()
	end
end)
-- }}}

-- Configure Plugins {{{
-- Setup LSP
require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")
-- Configure languages
-- lspconfig.<LANG>.setup {}

-- Setup Language tools
require("Comment").setup()
require("ibl").setup() -- Blank line

-- Setup Autocomplete
local cmp = require("cmp")
cmp.setup {
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    })
}

-- Setup Search & Fuzzy find
require('telescope').setup({
    defaults = {
        path_display = {
            "truncate"
        }
    }
})

-- Setup Theme 
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
})

-- Setup Dashboard/Greeter
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
        return ":e ~/AppData/Local/nvim/init.lua<CR>"
    else
        return ":e ~/.config/nvim/init.lua<CR>"
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

-- Setup Status line
require("lualine").setup {
    options = {
        icons_enabled = false
    }
}
-- }}}

-- Options {{{
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
vim.g.netrw_liststyle = 3

-- Folds
vim.opt.foldmethod = "marker"

-- Shell
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "powershell"
    vim.opt.shellquote = "\""
    vim.opt.shellxquote = ""
    vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
end
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")
-- }}}

-- Mappings {{{
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- File/Explorer Mappings
-- (normal mode) 
-- Open explorer
vim.keymap.set("n", "<leader>ex", ":Ex<CR>", {desc = "[Ex]plore files"})

-- Tab Mappings
-- (normal mode) 
vim.keymap.set("n", "<leader>tao", ":tabnew|Ex<CR>", {desc = "[Ta]b [O]pen"})
vim.keymap.set("n", "<leader>tac", ":tabclose<CR>", {desc = "[Ta]b [C]lose"})
vim.keymap.set("n", "<leader>tab", ":1tabnext<CR>", {desc = "[Ta]b [B]eginning"})
vim.keymap.set("n", "<leader>tae", ":tabnext$<CR>", {desc = "[Ta]b [E]nd"})
vim.keymap.set("n", "<leader>tan", ":+tabnext<CR>", {desc = "[Ta]b [N]ext"}) 
vim.keymap.set("n", "<leader>tap", ":-tabnext<CR>", {desc = "[Ta]b [P]revious"}) 

-- Window Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>wnh", "<c-w>n", {desc = "[W]indow [N]ew [H]orizontal"})
vim.keymap.set("n", "<leader>wnv", ":vnew<CR>",{desc = "[W]indow [N]ew [V]ertical"})
vim.keymap.set("n", "<leader>wq", "<c-w>q", {desc = "[W]indow [Q]uit"})
vim.keymap.set("n", "<leader>ww", "<c-w>w", {desc = "[W]indow cycle"})
vim.keymap.set("n", "<leader>wh", "<c-w>h", {desc = "[W]indow left"})
vim.keymap.set("n", "<leader>wl", "<c-w>l", {desc = "[W]indow right"})

-- Buffer Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", {desc = "[B]uffer [P]revious"})
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {desc = "[B]uffer [N]ext"})
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", {desc = "[B]uffer [D]elete"})

-- Movement/Text Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>u", ":u<CR>", {desc = "[U]ndo"})
vim.keymap.set("n", "<leader>r", ":red<CR>", {desc = "[R]edo"})
vim.keymap.set("n", "<leader>wu", "<C-u>zz", {desc = "[W]indow [U]p"})
vim.keymap.set("n", "<leader>wd", "<C-d>zz", {desc = "[W]indow [D]own"})
vim.keymap.set("n", "<leader>p", [["_d]]) -- Paste and keep

-- (visual mode)
vim.keymap.set("v", "<leader>u", ":m-2<CR>gv=gv", {desc = "Move line [U]p"})
vim.keymap.set("v", "<leader>d", ":m+1<CR>gv=gv", {desc = "Move line [D]own"})

-- Telescope Mappings
-- (normal mode)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc = "[F]ind [B]uffers"})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]iles"})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {desc = "[F]ind [G]it"})
vim.keymap.set("n", "<leader>fl", builtin.live_grep, {desc = "[F]ind [L]ive"})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({search = vim.fn.input("Grep > ")})
end, {desc = "[F]ile [S]earch"})

-- Misc. Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>nhl", ":nohlsearch<CR>", {desc = "[N]o [H]igh[L]ight"})

-- LSP Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {desc = "[G]oto [D]efinition"})
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {desc = "[G]oto [D]eclaration"})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {desc = "[G]oto [R]eferences"})
vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation, {desc = "[G]oto [I]mplementation"})
vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, {desc = "[T]ype [D]efinition"})
vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {desc = "[D]ocument [S]ymbols"})
vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {desc = "[W]orkspace [S]ymbols"})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc = "[R]e[N]ame"})
-- }}}
