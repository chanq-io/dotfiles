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
            CLAUDE_CODE_EXECUTABLE = vim.fn.exepath("claude"),
          },
          defaults = {
            model = "Opus 4.7 (1M context)",
          },
        })
      end,
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          defaults = {
            auth_method = "chatgpt",
          },
        })
      end,
    },
    http = {
      copilot = function()
        local adapter = require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gpt-5.4",
            },
            top_p = {
              -- Upstream only excludes o1. gpt-5.x also rejects top_p.
              enabled = function(self)
                local model = self.schema.model.default
                if type(model) == "function" then
                  model = model()
                end
                return not vim.startswith(model, "o1") and not vim.startswith(model, "gpt-5")
              end,
            },
          },
        })
        -- Work around codecompanion bug where /responses-endpoint models
        -- index adapter.schema.model.choices as a table while it is still
        -- the lazy function exposed by the copilot adapter. Resolve eagerly.
        local choices_fn = adapter.schema.model.choices
        if type(choices_fn) == "function" then
          adapter.schema.model.choices = choices_fn(adapter, { async = false }) or {}
        end
        return adapter
      end,
    },
  },
  strategies = {
    chat = {
      adapter = "claude_code",
      keymaps = {
        -- Disable <C-c> closing the chat buffer — too easy to lose work.
        -- Use :q (or the usual neovim buffer commands) instead.
        close = false,
      },
      roles = {
        -- Only customize the LLM-side header: include the adapter name so
        -- we can tell which backend replied (claude_code vs copilot, etc.).
        -- Leaving `user` at default — parser.lua (interactions/chat/parser.lua)
        -- compares each header against config.interactions.chat.roles.user and
        -- any drift (module-cached local vs live config) causes user content
        -- to be missed, which surfaces as Anthropic 400s on the next turn.
        llm = function(adapter)
          return "  " .. adapter.formatted_name
        end,
      },
      slash_commands = {
        ["file"] = {
          keymaps = { modes = { i = "<C-f>" } },
        },
        ["buffer"] = {
          keymaps = { modes = { i = "<C-b>" } },
        },
      },
    },
  },
  extensions = {
    history = {
      enabled = true,
      opts = {
        picker = "telescope",
        auto_generate_title = false,
      },
    },
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_tools = true,
        -- Disabled: mcphub's variable registration looks up
        -- `config.interactions.chat.variables`, which codecompanion v19
        -- renamed to `editor_context`. Re-enable once mcphub ships a fix.
        make_vars = false,
        make_slash_commands = true,
      },
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
