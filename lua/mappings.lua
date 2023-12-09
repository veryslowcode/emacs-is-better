vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- File/Explorer Mappings
-- (normal mode) 
-- Open explorer
vim.keymap.set("n", "<leader>ex", ":Ex<CR>", {noremap = true})

-- Tab Mappings
-- (normal mode) 
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


-- Window Mappings
-- (normal mode)
-- Split window (horizontal)
vim.keymap.set("n", "<leader>wnh", "<c-w>n", {noremap = true})
-- Split window (vertical)
vim.keymap.set("n", "<leader>wnv", ":vnew<CR>",{noremap = true})
-- Cycle window 
vim.keymap.set("n", "<leader>ww", "<c-w>w", {noremap = true})
-- Cycle window left
vim.keymap.set("n", "<leader>wh", "<c-w>h", {noremap = true})
-- Cycle window right
vim.keymap.set("n", "<leader>wl", "<c-w>l", {noremap = true})
-- Quit the current window
vim.keymap.set("n", "<leader>wq", "<c-w>q", {noremap = true})


-- Buffer Mappings
-- (normal mode)
-- Previous buffer
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", {noremap = true})
-- Next buffer
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {noremap = true})
-- Delete buffer
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", {noremap = true})


-- Movement/Text Mappings
-- (normal mode)
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

-- (visual mode)
-- Move line up 
vim.keymap.set("v", "<leader>u", ":m-2<CR>gv=gv", {noremap=true})
-- Move line down
vim.keymap.set("v", "<leader>d", ":m+1<CR>gv=gv", {noremap=true})


-- Telescope Mappings
-- (normal mode)
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

-- Misc. Mappings
-- (normal mode)
-- Hide highlight
vim.keymap.set("n", "<leader>nhl", ":nohlsearch<CR>", {noremap=true})
