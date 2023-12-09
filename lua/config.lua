-- Setup Nightfox
require("nightfox").setup({
    options = {
        transparent = true
    }
})

-- Setup Treesitter for auto-
-- matic syntax highlighting
require("nvim-treesitter.configs").setup({
    -- Don't install parsers synchronously
    sync_install = false,
    -- Don't automatically install parsers
    auto_install = false,

    highlight = { enable = true },
    additional_vim_regex_highlighting = false
})

-- Setup LSP
require("mason").setup()
require("mason-lspconfig").setup()
require("cmp_nvim_lsp").setup()
local lspconfig = require("lspconfig")
--- Add language servers here
lspconfig.rust_analyzer.setup {
    settings = { ["rust-analyzer"] = {}}
}

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
