-- vim.g.zettel_path = '/Users/cardamom/src/personal/zettelkasten/'
-- vim.g.nv_search_paths = {vim.g.zettel_path}

pcall(function()
  local paths = vim.api.nvim_get_runtime_file('parser/vim.so', true)
  for _, p in ipairs(paths) do
    if p:match('treesitter%-grammar%-vim') then
      vim.treesitter.language.add('vim', { path = p })
      break
    end
  end
end)

