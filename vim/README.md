# Vim 配置使用说明

本目录包含 `vimrc`，用于让 Vim 开箱即用，配置项参考了同仓库的 Neovim 选项。

## 使用方式

1) 将配置链接到你的 `$HOME/.vimrc`：
```/dev/null/sh#L1-1
cp -f $HOME/unix-configs/vim/vimrc $HOME/.vimrc
```

2) 重新打开 Vim 生效。

## 注意事项

- `set clipboard=unnamedplus` 需要 Vim 编译时包含 `+clipboard`。
- `termguicolors` 默认注释，若终端支持 24 位色可手动开启。
- 快捷键：`Ctrl+Shift+C` 在可视模式复制选中内容、普通模式复制整行（依赖剪贴板支持）。

## 排查建议

在 Vim 中执行：
```/dev/null/vim#L1-1
:version
```
查看是否包含 `+clipboard`。