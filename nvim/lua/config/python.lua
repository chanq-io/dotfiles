-- Pin nvim's python3 provider to the pynvim-enabled venv if it exists
-- (macOS workflow). On NixOS the neovim wrapper bundles pynvim, so leave
-- python3_host_prog unset and let nvim auto-detect.
local venv_python = vim.fn.expand("~/.config/nvim_venv/bin/python")
if vim.fn.filereadable(venv_python) == 1 then
  vim.g.python3_host_prog = venv_python
end

vim.cmd [[
    autocmd BufWritePre * :%s/\s\+$//e
]]
