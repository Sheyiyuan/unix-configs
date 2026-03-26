# unix-configs

本仓库用于存放我在 *Unix（如 macOS / Linux）上的各种配置与自动化脚本，**以自用为主**，不定期更新维护。

## 仓库结构

- `git/`：Git 全局配置
- `gnome-shortcuts-backup/`：GNOME 快捷键配置备份
- `kitty/`：Kitty 终端配置与主题
- `nvim/`：Neovim 配置
- `vim/`：Vim 配置
- `zsh/`：Zsh 配置

## 快速开始

各子目录内通常会有更详细的 `README.md`，请优先参考。

### Git 配置

```sh
cp -f ~/unix-configs/git/.gitconfig ~/.gitconfig
```

### Zsh 配置

```sh
cp -f ~/unix-configs/zsh/.zshrc ~/.zshrc
```

### Kitty 配置

```sh
mkdir -p ~/.config/kitty
cp -f ~/unix-configs/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

### Neovim 配置

```sh
mkdir -p ~/.config/nvim
cp -f ~/unix-configs/nvim/init.lua ~/.config/nvim/init.lua
cp -rf ~/unix-configs/nvim/lua ~/.config/nvim/lua
```

### Vim 配置

```sh
# 当前用户
cp -f ~/unix-configs/vim/vimrc ~/.vimrc

# root 用户
sudo cp -f ~/unix-configs/vim/vimrc /root/.vimrc

# 设置默认编辑器
sudo update-alternatives --set editor /usr/bin/vim.basic
```

**说明**：脚本会自动复制 vimrc 到当前用户和 root 用户，并设置系统默认编辑器。

### GNOME 快捷键

```sh
cd ~/unix-configs/gnome-shortcuts-backup
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < media-keys.ini
dconf load /org/gnome/desktop/wm/keybindings/ < wm-keybindings.ini
```

## 自定义路径

配置文件中部分路径需要根据实际情况调整：

1. **GNOME 快捷键**：`gnome-shortcuts-backup/media-keys.ini` 中的应用程序路径
2. **Git 配置**：`.gitconfig` 中的用户名和邮箱

批量替换路径示例：

```sh
# 替换快捷键配置中的用户路径
cd ~/unix-configs/gnome-shortcuts-backup
sed -i "s|/home/syy|$HOME|g" media-keys.ini
```

## 维护说明

- 这是个人配置仓库，随使用需求变化更新
- 可能包含平台/终端/字体等环境依赖
- 不保证稳定性或向后兼容

## 常见问题

### 1. 字体显示为方块或乱码

确保已安装 Nerd Font 并在终端设置中启用：

```sh
# 安装字体后刷新缓存
fc-cache -fv ~/.local/share/fonts
```

### 2. Zsh 主题不显示

确保已安装 Starship：

```sh
curl -sS https://starship.rs/install.sh | sh
```

### 3. Neovim 配置不生效

确保使用 Neovim 0.5+ 版本：

```sh
nvim --version  # 检查版本
```

### 4. GNOME 快捷键不生效

1. 确保在 GNOME 桌面环境中运行
2. 注销并重新登录
3. 检查应用程序路径是否正确
---

欢迎按需参考或 Fork 使用。
