-- Options {{{

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.wo.number = true

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.foldmethod = "marker"
vim.opt.clipboard = "unnamedplus"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- }}}

-- Plugins {{{

-- Mini.Pick
-- Source: https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/pick.lua
local pick = require("plugins.pick")
pick.setup()

vim.keymap.set(
  "n",
  "<leader>ff",  -- [F]ind [F]iles
  function()
    pick.builtin.files()
  end,
  { desc = ":Pick files" }
)

vim.keymap.set(
  "n",
  "<leader>fb", -- [F]ind [B]uffers
  function()
    pick.builtin.buffers()
  end,
  { desc = ":Pick buffers" }
)

vim.keymap.set(
  "n",
  "<leader>fs", -- [F]ind [S]tring
  function()
    pick.builtin.grep_live()
  end,
  { desc = ":Pick grep_live" }
)

-- }}}

