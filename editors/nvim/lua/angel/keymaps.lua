local mapper = require("util.keymapper").mapper

-- Buffer Navigation
mapper("<leader>bn", "bnext", "n")     -- Next buffer
mapper("<leader>bp", "bprevious", "n") -- Prev buffer
mapper("<leader>bb", "e #", "n")       -- Switch to Other Buffer
mapper("<leader>`", "e #", "n")        -- Switch to Other Buffer

-- Directory Navigation
mapper("<leader>m", "NvimTreeFocus", "n")
mapper("<leader>t", "NvimTreeToggle", "n")

-- Pane and Window Navigation
mapper("<C-h>", "<C-w>h", "n")            -- Navigate Left
mapper("<C-j>", "<C-w>j", "n")            -- Navigate Down
mapper("<C-k>", "<C-w>k", "n")            -- Navigate Up
mapper("<C-l>", "<C-w>l", "n")            -- Navigate Right
mapper("<C-h>", "wincmd h", "t")          -- Navigate Left
mapper("<C-j>", "wincmd j", "t")          -- Navigate Down
mapper("<C-k>", "wincmd k", "t")          -- Navigate Up
mapper("<C-l>", "wincmd l", "t")          -- Navigate Right
mapper("<C-h>", "TmuxNavigateLeft", "n")  -- Navigate Left
mapper("<C-j>", "TmuxNavigateDown", "n")  -- Navigate Down
mapper("<C-k>", "TmuxNavigateUp", "n")    -- Navigate Up
mapper("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window Management
mapper("<leader>sv", "vsplit", "n")          -- Split Vertically
mapper("<leader>sh", "split", "n")           -- Split Horizontally
mapper("<leader>sm", "MaximizerToggle", "n") -- Toggle Minimise

-- Indenting
mapper("<", "v", "<gv") -- Shift Indentation to Left
mapper(">", "v", ">gv") -- Shift Indentation to Right

-- Show Full File-Path
mapper("<leader>pa", "echo expand('%:p')", "n") -- Show Full File Path

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

