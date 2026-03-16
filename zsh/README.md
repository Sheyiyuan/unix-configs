# Zsh 配置说明（macOS）

本目录包含个人 `zsh` 配置文件：`.zshrc`。

## 依赖与可选插件

`.zshrc` 中使用了以下可选组件：
- **starship**：跨 shell 的提示符（prompt）
- **zsh-syntax-highlighting**：命令语法高亮

这些组件在 macOS 上可通过 Homebrew 安装。

## macOS 安装步骤

### 1) 安装 Homebrew（如已安装可跳过）
```/dev/null/sh#L1-1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2) 安装 starship
```/dev/null/sh#L1-1
brew install starship
```

### 3) 安装 zsh-syntax-highlighting
```/dev/null/sh#L1-1
brew install zsh-syntax-highlighting
```

### 4) 在 `.zshrc` 中启用（已配置）
当前 `.zshrc` 已包含以下逻辑：
- 如果 `starship` 存在，会自动启用
- 如果 `zsh-syntax-highlighting` 的脚本存在，会自动加载

如果你使用 Homebrew 默认路径，macOS 上的语法高亮脚本路径通常是：
```/dev/null/path#L1-1
/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```
或（Apple Silicon）：
```/dev/null/path#L1-1
/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

如果你的路径不同，请在 `.zshrc` 中更新相应路径。

## 快速检查

打开新终端后：
- 看到 starship 提示符说明已生效
- 输入命令时有高亮说明语法高亮已生效