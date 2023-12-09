vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Normal Mode Mappings
--
-- Open explorer
vim.keymap.set("n", "<leader>ex", ":Ex<CR>", {noremap = true})
-- Open terminal
vim.keymap.set("n", "<leader>to", ":terminal<CR>", {noremap = true})
-- Open terminal (horizontal split)
vim.keymap.set("n", "<leader>th", ":split|bottom|termianl<CR>", {noremap = true})
-- Open terminal (vertical split)
vim.keymap.set("n", "<leader>tv", ":vsplit|right|terminal<CR>", {noremap = true})
-- Open terminal in new tab
vim.keymap.set("n", "<leader>tat", ":tabnew|terminal<CR>", {noremap = true})
-- Open a new tab
vim.keymap.set("n", "<leader>tao", ":tabnew|Ex<CR>", {noremap = true})
-- First tab
vim.keymap.set("n", "<leader>tab", ":1tabnext<CR>", {noremap = true})
-- Next tab
vim.keymap.set("n", "<leader>tan", ":+tabnext<CR>", {noremap = true}) 
-- Previous tab
vim.keymap.set("n", "<leader>tap", ":-tabnext<CR>", {noremap = true}) 
-- Last tab
vim.keymap.set("n", "<leader>tae", ":tabnext$<CR>", {noremap = true})
-- Close tab
vim.keymap.set("n", "<leader>tac", ":tabclose<CR>", {noremap = true})
-- Split window (horizontal)
vim.keymap.set("n", "<leader>wnh", "<c-w>n", {noremap = true})
-- Split window (vertical)
vim.keymap.set("n", "<leader>wnv", "<c-w>v",{noremap = true})
-- Cycle window 
vim.keymap.set("n", "<leader>ww", "<c-w>w", {noremap = true})
-- Cycle window left
vim.keymap.set("n", "<leader>wh", "<c-w>h", {noremap = true})
-- Cycle window right
vim.keymap.set("n", "<leader>wl", "<c-w>l", {noremap = true})
-- Quit the current window
vim.keymap.set("n", "<leader>wq", "<c-w>q", {noremap = true})
-- Previous buffer
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", {noremap = true})
-- Next buffer
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {noremap = true})
-- Delete buffer
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", {noremap = true})
-- Undo
vim.keymap.set("n", "<leader>u", ":u<CR>", {noremap = true})
-- Redo
vim.keymap.set("n", "<leader>r", ":red<CR>", {noremap = true})
-- Paste and keep
vim.keymap.set("n", "<leader>p", [["_d]])
-- Scroll down with fixed cursor
vim.keymap.set("n", "<leader>wd", "<C-d>zz", {noremap = true})
-- Scroll up with fixed cursor
vim.keymap.set("n", "<leader>wu", "<C-u>zz", {noremap = true})
-- Toggle comments
--[[ Set in configs under Setup Code Comments section ]]

-- Telescope Mappings (normal mode)
local builtin = require("telescope.builtin")
-- Show open buffers
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- Find all files
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- Find git files
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
-- Live grep in files
vim.keymap.set("n", "<leader>fl", builtin.live_grep, {})
-- Grep in project
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({search = vim.fn.input("Grep > ")})
end, {})

-- Auto complete (normal mode)
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>p'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>n'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    })
})

-- Diagnostic Mappings (normal mode)
--
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, {noremap = true})
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {noremap = true})
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {noremap = true})

-- LSP Mappings (normal mode)
--
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"        
        local opts = {buffer = ev.buf}

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {noremap = true})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {noremap = true})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {noremap = true})
        vim.keymap.set("n", "<leader>gm", vim.lsp.buf.implementation, {noremap = true})
        vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, {noremap = true})
        vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, {noremap = true})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {noremap = true})
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format { async = true }
            end, {noremap = true})
    end
})

-- Visual Mode Mappings
--
-- Move line up 
vim.keymap.set("v", "<leader>u", ":m-2<CR>gv=gv", {noremap=true})
-- Move line down
vim.keymap.set("v", "<leader>d", ":m+1<CR>gv=gv", {noremap=true})
-- Toggle Comments
--[[ Set in configs under Setup Code Comments section ]]

-- Terminal Mode Mappings
--
-- ESC terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>", {noremap = true})
