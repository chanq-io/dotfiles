# Load Claude API key from 1Password with timeout and authentication check
# Only attempt if 1Password CLI is available and authenticated
if command -v op &> /dev/null; then
  # Check if already authenticated (this is fast).
  # setsid detaches from the controlling tty; otherwise op opens /dev/tty
  # directly when no accounts are configured and jams the shell with an
  # interactive "add account?" prompt that bypasses stdin redirects.
  if setsid -w op account list </dev/null &> /dev/null; then
    # Use timeout to prevent hanging (3 seconds max)
    CLAUDE_CODE_OAUTH_TOKEN=$(timeout 3 setsid -w op read op://personal/ClaudeAPI/credential --no-newline </dev/null 2>/dev/null)
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

