# op-based CLAUDE_CODE_OAUTH_TOKEN loading removed — claudecode.nvim
# connects to the running Claude Code CLI session over a local WebSocket
# (no API key needed). Left here in case op is needed for other secrets
# in the future.

if [[ -f ~/.private_zsh_keys.zsh ]]; then
  source ~/.private_zsh_keys.zsh
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
export SSH_AUTH_SOCK_BRIDGE="$SSH_AUTH_SOCK"

