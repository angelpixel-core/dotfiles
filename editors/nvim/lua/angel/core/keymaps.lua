vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- AI Assistant
keymap.set({ "n", "v" }, "<leader>ge", ":Gen<CR>", { desc = "Open AI Assistant Menu" })
keymap.set({ "n", "v" }, "<leader>gp", ":ChatGPT<CR>", { desc = "Open AI Assistant Menu" })

-- Copy Path
function copy_current_dir_path()
  local dir_path = vim.fn.expand("%:p:h")
  if dir_path == "" then
    vim.notify("No hay directorio asociado al buffer actual 📁", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", dir_path) -- Copia al portapapeles
  vim.notify("Directorio copiado al portapapeles! 📋", vim.log.levels.INFO)
end

keymap.set(
  { "n" },
  "<leader>d",
  copy_current_dir_path,
  { desc = "Copy Current Dir File", noremap = true, silent = true }
)

-- NoteTaker
