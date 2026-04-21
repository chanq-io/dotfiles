return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    init = function()
        vim.treesitter.language.register('markdown', 'telekasten')
    end,
    opts = {
        file_types = { 'markdown', 'telekasten' },
        completions = { lsp = { enabled = true } },
    },
}

