--      ___           ___           ___           ___     
--     /\__\         /\  \         /\  \         |\__\    
--    /:/  /        /::\  \       /::\  \        |:|  |   
--   /:/  /        /:/\:\  \     /:/\:\  \       |:|  |   
--  /:/__/  ___   /::\~\:\  \   /::\~\:\  \      |:|__|__ 
--  |:|  | /\__\ /:/\:\ \:\__\ /:/\:\ \:\__\     /::::\__\
--  |:|  |/:/  / \:\~\:\ \/__/ \/_|::\/:/  /    /:/~~/~   
--  |:|__/:/  /   \:\ \:\__\      |:|::/  /    /:/  /     
--   \::::/__/     \:\ \/__/      |:|\/__/     \/__/      
--    ~~~~          \:\__\        |:|  |                  
--                   \/__/         \|__|                  
--      ___           ___       ___           ___         
--     /\  \         /\__\     /\  \         /\__\        
--    /::\  \       /:/  /    /::\  \       /:/ _/_       
--   /:/\ \  \     /:/  /    /:/\:\  \     /:/ /\__\      
--  _\:\~\ \  \   /:/  /    /:/  \:\  \   /:/ /:/ _/_     
-- /\ \:\ \ \__\ /:/__/    /:/__/ \:\__\ /:/_/:/ /\__\    
-- \:\ \:\ \/__/ \:\  \    \:\  \ /:/  / \:\/:/ /:/  /    
--  \:\ \:\__\    \:\  \    \:\  /:/  /   \::/_/:/  /     
--   \:\/:/  /     \:\  \    \:\/:/  /     \:\/:/  /      
--    \::/  /       \:\__\    \::/  /       \::/  /       
--     \/__/         \/__/     \/__/         \/__/        
--      ___           ___           ___           ___     
--     /\  \         /\  \         /\  \         /\  \    
--    /::\  \       /::\  \       /::\  \       /::\  \   
--   /:/\:\  \     /:/\:\  \     /:/\:\  \     /:/\:\  \  
--  /:/  \:\  \   /:/  \:\  \   /:/  \:\__\   /::\~\:\  \ 
-- /:/__/ \:\__\ /:/__/ \:\__\ /:/__/ \:|__| /:/\:\ \:\__\
-- \:\  \  \/__/ \:\  \ /:/  / \:\  \ /:/  / \:\~\:\ \/__/
--  \:\  \        \:\  /:/  /   \:\  /:/  /   \:\ \:\__\  
--   \:\  \        \:\/:/  /     \:\/:/  /     \:\ \/__/  
--    \:\__\        \::/  /       \::/__/       \:\__\    
--     \/__/         \/__/         ~~            \/__/    

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
	"git", "clone", "--filter=blob:none",
	"--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim & Plugin Configuration
require("lazy").setup({
  spec = {

    -- Theme {{{
    --
    { "savq/melange-nvim" },
    --
    -- }}}

    -- Dashboard/Greeter {{{
    --
    {
        "goolord/alpha-nvim",
        config = function ()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[      ___           ___                       ___     ]],
                [[     /\__\         /\__\          ___        /\__\    ]],
                [[    /::|  |       /:/  /         /\  \      /::|  |   ]],
                [[   /:|:|  |      /:/  /          \:\  \    /:|:|  |   ]],
                [[  /:/|:|  |__   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
                [[ /:/ |:| /\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
                [[ \/__|:|/:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
                [[     |:/:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
                [[     |::/  /     \::::/__/    \:\__\          /:/  /  ]],
                [[     /:/  /       ~~~~         \/__/         /:/  /   ]],
                [[     \/__/                                   \/__/    ]],
            }

            local function getConfig()
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
        end
    },
    --
    -- }}}

    -- File/Fuzzy Find {{{
    --
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        vertical = { width = 0.75 },
                        preview_cutoff = 1
                    },
                    layout_strategy = "vertical",
                    path_display = {
                        "truncate"
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true
                    }
                }
            })
        end
    },
    --
    -- }}}

    -- Directory/File Management {{{
    --
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension "file_browser"
        end
    },
    --
    -- }}}

    -- Status Line {{{
    --
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = false,
                    always_divide_middle = true,
                },
                inactive_sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            }
        end
    },
    --
    -- }}}

    -- Notifications {{{
    --
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0
                }
            }
        }
    },
    --
    -- }}}

    -- Version Control {{{
    --
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = {text = '+'},
                    change = { text = '~' },
                    delete = { text = '-' },
                },
                signs_staged = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '-' },
                }
            }
        end
    },
    --
    -- }}}

    -- Non-LSP Language Tools {{{
    --
    { 
        "numToStr/Comment.nvim", 
        config = function()
            require("Comment").setup()
        end
    },
    { 
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    --
    -- }}}

    -- Autocomplete {{{
    --
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
        },
        config = function()
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
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            }
        end,    
    },
    --
    -- }}}

    -- LSP {{{
    --
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            require("mason").setup({
                ui = { border = "rounded" }
            })
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")
            -- Configure languages
            -- lspconfig.<LANG>.setup {}
        end
    },
    --
    -- }}}

  },
  checker = { enabled = false },
  ui = {
    border = "rounded"
  },
})

-- General Options {{{
--
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Tab with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Incremental search
vim.opt.incsearch = true

-- Incremental command
vim.opt.inccommand = "split"

-- Ensure minimum lines shown
vim.opt.scrolloff = 10

-- Set linenumbers
vim.wo.number = true
vim.o.cursorline = true

-- Theme
vim.cmd.colorscheme "melange"

-- Window split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Folds
vim.opt.foldmethod = "marker"

-- Copy & Paste
vim.opt.clipboard = "unnamedplus" -- Always copy to system clipboard

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

-- Add borders
require("lspconfig.ui.windows").default_options.border = "rounded"
local _border = "rounded"
vim.diagnostic.config { float = { border=_border } }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = _border }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = _border }
)
--
-- }}}

-- Custom Functionality {{{
--
local delete_selection = function(selection)
    vim.api.nvim_buf_delete(selection.bufnr, {force = true})
end

local find_buffers_override = function()
    local builtin = require("telescope.builtin")
    builtin.buffers({
        initial_mode = "normal",
        attach_mappings = function(buffnum, map)
            local delete_buffer = function()
                local state = require("telescope.actions.state")
                local picker = state.get_current_picker(buffnum)
                picker:delete_selection(delete_selection)
            end
            map("n", "db", delete_buffer, {desc = "[D]elete [B]uffer"})
            return true
        end
    })
end
--
-- }}}

-- Mappings {{{
--
-- File/Explorer Mappings
-- (normal mode) 
-- Open explorer
vim.keymap.set("n", "<leader>ex", ":Ex<CR>", {desc = "[Ex]plore files"})

-- Tab Mappings
-- (normal mode) 
vim.keymap.set("n", "<leader>tao", ":tabnew|Telescope file_browser<CR>", {desc = "[Ta]b [O]pen"})
vim.keymap.set("n", "<leader>tto", ":tabnew|term<CR>", {desc = "[T]erminal [T]ab [O]pen"})
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
vim.keymap.set("n", "<leader>wj", "<c-w>j", {desc = "[W]indow down"})
vim.keymap.set("n", "<leader>wk", "<c-w>k", {desc = "[W]indow up"})
vim.keymap.set("n", "<M-,>", "<c-w>5<", {desc = "Risize Window Right"})
vim.keymap.set("n", "<M-.>", "<c-w>5>", {desc = "Resize Window Left"})
vim.keymap.set("n", "<M-p>", "<c-w>+", {desc = "Risize Window Increase"})
vim.keymap.set("n", "<M-o>", "<c-w>-", {desc = "Resize Window Decrease"})

-- Terminal Mappings
-- (normal mode)
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Double escape exit terminal mode"})

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
vim.keymap.set("n", "<leader>fb", find_buffers_override, {desc = "[F]ind [B]uffers"})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]iles"})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {desc = "[F]ind [G]it"})
vim.keymap.set("n", "<leader>fl", builtin.live_grep, {desc = "[F]ind [L]ive"})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({search = vim.fn.input("Grep > ")})
end, {desc = "[F]ile [S]earch"})

vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", {desc = "[F]ile [E]xplorer"})
vim.keymap.set("n", "<leader>fec", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {desc = "[F]ile [E]xplorer [C]urrent"})

-- Version Control Mappings
-- (normal mode)
vim.keymap.set("n", "<leader>ng", ":Neogit<CR>", {desc = "[N]eo [G]it"})
vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", {desc = "[H]unk [S]tage"})
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", {desc = "[H]unk [R]eset"})
vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", {desc = "[H]unk [S]tage Buffer"})
vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", {desc = "[H]unk [R]eset Buffer"})
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", {desc = "[H]unk [U]ndo"})
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", {desc = "[H]unk [P]review"})
vim.keymap.set("n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", {desc = "[H]unk [B]lame"})
vim.keymap.set("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", {desc = "[T]oggle [B]lame"})
vim.keymap.set("n", "<leader>tD", "<cmd>Gitsigns toggle_deleted<CR>", {desc = "[T]oggle [D]elete"})

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
vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, {desc = "[O]pen [F]loat"})
--
-- }}}

