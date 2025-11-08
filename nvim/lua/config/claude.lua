require("codecompanion").setup({
  log_level = "DEBUG",
  strategies = {
    chat = {
      adapter = "claude_code",
    },
  },
  adapters = {
    acp = {
      claude_code = {
        name = "claude_code",
        schema = {
          model = {
            default = "claude-3-5-sonnet-20241022",
          },
        },
        env = {
          CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://personal/ClaudeAPI/credential --no-newline",
        },
        -- Specify it's an ACP adapter
        cmd = "npx --silent --yes @zed-industries/claude-code-acp",
      }
    }
  }
})
