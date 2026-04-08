require("codecompanion").setup({
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://personal/ClaudeAPI/credential --no-newline",
          },
        })
      end,
    },
  },
  strategies = {
    chat = {
      adapter = "claude_code",
    },
  },
})
