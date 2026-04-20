-- Locate python3 using PATH
-- local python_path = vim.fn.exepath("python3")
-- if python_path == nil or python_path == "" then
--   python_path = vim.g.homebrew_install_dir .. "/bin/python3"
--   if utils.file_or_dir_exists(python_path) then
--     vim.g.python3_host_prog = python_path
--   end
-- else
--   vim.g.python3_host_prog = python_path
-- end
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim_venv/bin/python")

vim.cmd [[
    autocmd BufWritePre * :%s/\s\+$//e
]]
