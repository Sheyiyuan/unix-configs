# Neovim 配置说明

本目录为 `nvim` 配置，入口文件为 `init.lua`，默认加载 `lua/options.lua`。

## 使用方式

### 1) 直接使用
将此目录作为 Neovim 配置目录（推荐复制）：

- 配置目录：`$HOME/.config/nvim`
- 示例（复制）：
  - `cp -r $HOME/unix-configs/nvim $HOME/.config/nvim`

### 2) 生效方式
启动 `nvim` 后配置会自动加载，无需额外命令。

## 说明

- `init.lua`：配置入口
- `lua/options.lua`：基础选项与按键映射

如需扩展插件或模块，可在 `lua/` 下新增模块并在 `init.lua` 中 `require`。