# ===== 历史记录设置 =====
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS

# ===== 提示符（存在时启用 starship）=====
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ===== 语法高亮（存在时启用）=====
if [ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ===== 补全设置 =====
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit -u

# ===== 通用环境变量（存在时加载）=====
if [ -r "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

# ===== 常用别名 =====
alias nano='nvim'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias npm='pnpm'
alias npx='pnpm exec'
alias vim='nvim'
