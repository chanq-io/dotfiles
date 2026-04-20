local function read_global_rules()
  local path = "/Users/cardamom/Code/personal/GLOBAL_AGENTS.md"
  local f = io.open(path, "r")
  if not f then
    return ""
  end
  local content = f:read("*a")
  f:close()
  return content
end

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
  opts = {
    system_prompt = function(opts)
      -- To append to CodeCompanion's built-in default, uncomment:
      -- local default = require("codecompanion.config").config.opts.system_prompt(opts)
      -- return default .. "\n\n" .. read_global_rules()
      return read_global_rules()
    end,
  },
})
