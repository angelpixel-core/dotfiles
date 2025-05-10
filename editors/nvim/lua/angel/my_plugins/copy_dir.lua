local M = {}

function M.copy_current_dir_path()
  local dir_path = vim.fn.expand("%:p:h")
  if dir_path == "" then
    vim.notify("No hay directorio asociado al buffer actual 📁", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", dir_path) -- Copia al portapapeles
  vim.notify("Directorio copiado al portapapeles! 📋", vim.log.levels.INFO)
end

return M
