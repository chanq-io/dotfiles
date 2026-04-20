# Load Claude API key from 1Password with timeout and authentication check
# Only attempt if 1Password CLI is available and authenticated
if command -v op &> /dev/null; then
  # Check if already authenticated (this is fast).
  # </dev/null prevents op from opening an interactive "add account"
  # prompt on /dev/tty when no accounts are configured — that prompt
  # bypasses &>/dev/null and jams the shell at startup.
  if op account list </dev/null &> /dev/null; then
    # Use timeout to prevent hanging (3 seconds max)
    CLAUDE_CODE_OAUTH_TOKEN=$(timeout 3 op read op://personal/ClaudeAPI/credential --no-newline </dev/null 2>/dev/null)
    if [[ $? -eq 0 && -n "$CLAUDE_CODE_OAUTH_TOKEN" ]]; then
      export CLAUDE_CODE_OAUTH_TOKEN
    else
      # Fallback: try to load from cache or skip
      unset CLAUDE_CODE_OAUTH_TOKEN
    fi
  fi
fi

if [[ -f ~/.private_zsh_keys.zsh ]]; then
  source ~/.private_zsh_keys.zsh
fi

