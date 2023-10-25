local keymapper = require("util.keymapper")

-- Buffer Navigation
keymapper("<leader>bn", "bnext", "n")     -- Next buffer
keymapper("<leader>bp", "bprevious", "n") -- Prev buffer
keymapper("<leader>bb", "e #", "n")       -- Switch to Other Buffer
keymapper("<leader>`", "e #", "n")        -- Switch to Other Buffer

-- Directory Navigation
keymapper("<leader>m", "NvimTreeFocus", "n")
keymapper("<leader>t", "NvimTreeToggle", "n")

-- Pane and Window Navigation
keymapper("<C-h>", "<C-w>h", "n")            -- Navigate Left
keymapper("<C-j>", "<C-w>j", "n")            -- Navigate Down
keymapper("<C-k>", "<C-w>k", "n")            -- Navigate Up
keymapper("<C-l>", "<C-w>l", "n")            -- Navigate Right
keymapper("<C-h>", "wincmd h", "t")          -- Navigate Left
keymapper("<C-j>", "wincmd j", "t")          -- Navigate Down
keymapper("<C-k>", "wincmd k", "t")          -- Navigate Up
keymapper("<C-l>", "wincmd l", "t")          -- Navigate Right
keymapper("<C-h>", "TmuxNavigateLeft", "n")  -- Navigate Left
keymapper("<C-j>", "TmuxNavigateDown", "n")  -- Navigate Down
keymapper("<C-k>", "TmuxNavigateUp", "n")    -- Navigate Up
keymapper("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window Management
keymapper("<leader>sv", "vsplit", "n")          -- Split Vertically
keymapper("<leader>sh", "split", "n")           -- Split Horizontally
keymapper("<leader>sm", "MaximizerToggle", "n") -- Toggle Minimise

-- Indenting
keymapper("<", "v", "<gv") -- Shift Indentation to Left
keymapper(">", "v", ">gv") -- Shift Indentation to Right

-- Show Full File-Path
keymapper("<leader>pa", "echo expand('%:p')", "n") -- Show Full File Path

local api = vim.api

-- Zen Mode
api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})

-- Comments
api.nvim_set_keymap("n", "<C-_>", "gtc", { noremap = false })
api.nvim_set_keymap("v", "<C-_>", "goc", { noremap = false })
