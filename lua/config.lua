-- Setup Catppuccin 
require("catppuccin").setup({
    flavour = "mocha"
})

-- Setup Treesitter for auto-
-- matic syntax highlighting
require("nvim-treesitter.configs").setup({
    -- Install parsers synchronously
    sync_install = true,
    -- Automatically install parsers
    auto_install = true,

    highlight = { enable = true },
    additional_vim_regex_highlighting = false
})

-- Setup LSP
require("mason").setup()
require("mason-lspconfig").setup({
    -- Additional languages as necessary
    ensure_installed = {
        "rust_analyzer", "pylsp", "lua_ls"
    }
})
require("cmp_nvim_lsp").setup()
local lspconfig = require("lspconfig")
--- Add language servers here
lspconfig.rust_analyzer.setup {
    settings = { ["rust-analyzer"] = {}}
}
lspconfig.pylsp.setup {}
lspconfig.lua_ls.setup {}

-- Setup Code Comments
require("Comment").setup({
    toggler = {
        line = "<leader>cl",
        block = "<leader>cb"
    },
    opleader = {
        line = "<leader>cl",
        block = "<leader>cb"
    }
})

-- Setup Auto complete
local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = 'nvim_lsp' }
    }
})
