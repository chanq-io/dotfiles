require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "just" },
  },
})
require("just").setup({
    fidget_message_limit = 32, -- limit for length of fidget progress message
    open_qf_on_error = true,   -- opens quickfix when task fails
    open_qf_on_run = true,     -- opens quickfix when running `run` task (`:JustRun`)
    open_qf_on_any = false;    -- opens quickfix when running any task (overrides other open_qf options)
    autoscroll_qf = true,      -- automatically scroll quickfix window on output
    register_commands = true,  -- if set to true then commands (:Just*) will be registered
    notify = vim.notify,       -- what to use to show messages/errors
})
