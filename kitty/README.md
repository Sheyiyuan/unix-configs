# Kitty 配置使用说明

本目录包含 Kitty 终端的配置文件，目标是让配置可复用、可同步。

## 目录结构

- `kitty.conf`：主配置入口
- `current-theme.conf`：当前主题颜色覆盖层（由主题生成器更新）
- `themes/`：主题模板或主题文件集合

## 使用方式（推荐：软链接）

将本目录下的配置链接到 Kitty 的默认配置路径：

```/dev/null/sh#L1-2
mkdir -p $HOME/.config/kitty
ln -sf $HOME/unix-configs/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
```

如果你想把整目录都链接过去（包含主题文件）：

```/dev/null/sh#L1-1
ln -sf $HOME/unix-configs/kitty $HOME/.config/kitty
```

## 主题更新说明

`kitty.conf` 中通过 `include current-theme.conf` 引入颜色配置。  
当你用主题生成器（如 Matugen）更新颜色时，只需要更新 `current-theme.conf` 即可。

## 常见调整点

- 字体：在 `kitty.conf` 中调整 `font_family`
- 窗口透明：在 `kitty.conf` 中调整 `background_opacity`
- 窗口边框：在 `kitty.conf` 中调整 `hide_window_decorations`
