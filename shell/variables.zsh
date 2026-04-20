# Load Claude API key from 1Password with timeout and authentication check
# Only attempt if 1Password CLI is available and authenticated
if command -v op &> /dev/null; then
  # </dev/null suppresses op's interactive "add account?" prompt when
  # no accounts are configured. Stay out of a new session (no setsid)
  # so op can talk to the desktop app over DBus for session caching.
  if op account list </dev/null &> /dev/null; then
    # Timeout guards against a wedged op; generous enough for the
    # first-unlock polkit/biometric dialog. Subsequent shells hit a
    # cached session and return instantly.
    CLAUDE_CODE_OAUTH_TOKEN=$(timeout 10 op read op://personal/ClaudeAPI/credential --no-newline </dev/null 2>/dev/null)
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

