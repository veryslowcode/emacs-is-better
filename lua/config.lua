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
        "rust_analyzer", "pylsp", "lua_ls", "omnisharp"
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
lspconfig.omnisharp.setup {}

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

-- Setup Debugging
local dap, dapui = require("dap"), require("dapui")

dapui.setup({
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "󰞖",
      step_over = "󰤼",
      step_out = "󰞙",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

local dap_python = require("dap-python")

-- Global python
dap_python.setup("python")

-- Static environment
-- local debugpy_path = "" -- Change this to your debugpy location
-- dap_python.setup(debugpy_path)

-- Custom path prompt
-- dap_python.setup()
-- dap_python.resolve_python = function()
--     return vim.fn.input("Environment: ", vim.fn.getcwd().."", "file")
-- end

-- Setup Alpha
require("alpha").setup(
    require"alpha.themes.dashboard".config
)
