vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
  -- Add per-buffer LSP keymaps here if you want buffer-local bindings.
  -- You already set global keymaps below, so this can stay empty.
end

local opts = {
  tools = {
    runnables = { use_telescope = true },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = {
    on_attach = on_attach,
    settings = {},
  },
}

-- rustaceanvim handles Rust
vim.g.rustaceanvim = {
  tools = {},
  server = {
    on_attach = function(client, bufnr)
      -- per-buffer Rust keymaps if you want
    end,
    default_settings = {
      ['rust-analyzer'] = {},
    },
  },
  dap = {},
}

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      -- Requires 'vim-vsnip' plugin for this to work
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- Global LSP keymaps (you already have these)
vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gD", vim.lsp.buf.implementation)
vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

vim.opt.updatetime = 100

local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
  group = diag_float_grp,
})

vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next)
vim.wo.signcolumn = "yes"

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

-- LSP servers (no mason; binaries provided by Nix)
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- C/C++
lsp.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JavaScript / TypeScript
local ts_name = lsp.ts_ls and "ts_ls" or "tsserver"
lsp[ts_name].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML / CSS
lsp.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Bash
lsp.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- YAML
lsp.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TOML (Taplo)
lsp.taplo.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Rust is handled by rustaceanvim (do not set rust_analyzer here)
