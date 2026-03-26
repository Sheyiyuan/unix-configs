# GNOME 快捷键备份说明

本目录包含 GNOME 桌面环境的快捷键配置备份，用于在不同机器或重装系统后快速恢复个人快捷键设置。

## 文件说明

- `media-keys.ini`：媒体键和自定义快捷键配置
  - 来源路径：`/org/gnome/settings-daemon/plugins/media-keys/`
  - 包含自定义应用启动快捷键（如 `Super+d` 打开文件管理器、`Super+t` 打开终端等）

- `wm-keybindings.ini`：窗口管理器快捷键配置
  - 来源路径：`/org/gnome/desktop/wm/keybindings/`
  - 包含窗口切换、工作区切换、窗口操作等快捷键

## 使用方式

### 1) 恢复快捷键配置

使用 `dconf load` 命令导入备份的配置文件：

```sh
# 恢复媒体键和自定义快捷键
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < media-keys.ini

# 恢复窗口管理器快捷键
dconf load /org/gnome/desktop/wm/keybindings/ < wm-keybindings.ini
```

执行后需要**注销并重新登录**或重启系统使配置生效。

### 2) 备份当前快捷键配置

如果你想将当前系统的快捷键配置备份到此目录：

```sh
# 导出媒体键配置
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > media-keys.ini

# 导出窗口管理器快捷键配置
dconf dump /org/gnome/desktop/wm/keybindings/ > wm-keybindings.ini
```

### 3) 查看当前快捷键配置

```sh
# 查看媒体键配置
dconf dump /org/gnome/settings-daemon/plugins/media-keys/

# 查看窗口管理器快捷键配置
dconf dump /org/gnome/desktop/wm/keybindings/
```

## 当前快捷键列表

### 自定义应用启动快捷键（media-keys.ini）

| 快捷键 | 命令 | 说明 |
|--------|------|------|
| `Super+d` | `nautilus` | 打开文件管理器 |
| `Super+b` | `microsoft-edge-stable --start-maximized` | 打开 Edge 浏览器（配置名为 chromium） |
| `Super+t` | `kitty` | 打开终端 |
| `Super+m` | `half-beat` | 打开音乐播放器 |
| `Super+c` | `code` | 打开 VS Code |
| `Super+w` | `$HOME/.local/share/applications/WebStorm-*/bin/webstorm` | 打开 WebStorm |
| `Super+p` | `$HOME/.local/share/applications/pycharm-*/bin/pycharm` | 打开 PyCharm |
| `Super+g` | `$HOME/.local/share/applications/Godot_*/Godot_*` | 打开 Godot 引擎 |
| `Super+a` | `/opt/"Cherry Studio"/CherryStudio` | 打开 Cherry Studio |
| `Super+z` | `$HOME/.local/bin/zed` | 打开 Zed 编辑器 |
| `Super+n` | `kitty -- flatpak run io.github.go_musicfox.go-musicfox` | 打开 musicfox |

### 窗口管理器快捷键（wm-keybindings.ini）

| 快捷键 | 功能 |
|--------|------|
| `Super+q` | 关闭窗口 |
| `Super+f` | 最大化/还原窗口 |
| `Super+Tab` | 切换应用（向前） |
| `Shift+Super+Tab` | 切换应用（向后） |
| `Alt+Tab` | 切换窗口（向前） |
| `Shift+Alt+Tab` | 切换窗口（向后） |
| `Shift+Super+1` | 移动窗口到工作区 1 |
| `Shift+Super+2` | 移动窗口到工作区 2 |
| `Shift+Super+3` | 移动窗口到工作区 3 |
| `Shift+Super+4` | 移动窗口到工作区 4 |
| `Shift+Super+Left` | 移动窗口到左侧工作区 |
| `Shift+Super+Right` | 移动窗口到右侧工作区 |
| `Control+Super+Left` | 切换到左侧工作区 |
| `Control+Super+Right` | 切换到右侧工作区 |
| `Shift+Super+Up` | 移动窗口到上方显示器 |
| `Shift+Super+Down` | 移动窗口到下方显示器 |
| `Shift+Super+KP_Insert` | 移动窗口到上方显示器（小键盘） |
| `Shift+Super+KP_Delete` | 移动窗口到下方显示器（小键盘） |

## 添加自定义快捷键

如果你想添加新的自定义快捷键，可以使用以下命令：

```sh
# 1. 获取当前的自定义键绑定列表
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings

# 2. 添加新的自定义键绑定（示例：添加 Super+k 打开计算器）
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'calculator'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-calculator'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>k'

# 3. 更新自定义键绑定列表（包含新的 custom0）
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
```

注意：`custom0`、`custom1` 等编号需要唯一，如果已存在则使用下一个可用编号。

## 注意事项

1. **路径依赖**：配置文件中的命令路径（如 `$HOME/.local/...`）需要根据你的实际路径调整
2. **应用依赖**：确保系统中已安装配置文件中引用的应用程序
3. **自定义键绑定**：如果导入后自定义快捷键不生效，可能需要先重置自定义键绑定列表：
   ```sh
   gsettings reset org.gnome.settings-daemon.plugins.media-keys custom-keybindings
   ```
4. **GNOME 版本**：不同 GNOME 版本的配置路径可能略有差异，请根据实际情况调整

## 快速替换路径示例

如果你需要将配置文件中的路径批量替换为自己的路径，可以使用 `sed` 命令：

```sh
# 将 /home/syy 替换为你的实际用户名（注意：必须使用绝对路径）
sed -i 's|/home/syy|/home/yourname|g' media-keys.ini

# 或使用环境变量展开（双引号允许 $HOME 展开）
sed -i "s|/home/syy|$HOME|g" media-keys.ini

# 替换特定应用路径（示例：替换 WebStorm 版本）
sed -i 's|WebStorm-252.28238.10|WebStorm-2024.1|g' media-keys.ini
```

**重要**：GNOME 的 dconf 不会解析 `$HOME` 变量，配置文件中的路径必须是展开后的绝对路径。使用双引号可以让 shell 在运行 sed 前先将 `$HOME` 展开为实际路径。

## 参考

- [GNOME 快捷键官方文档](https://help.gnome.org/users/gnome-help/stable/keyboard-shortcuts.html)
- [dconf 工具文档](https://wiki.gnome.org/Projects/dconf)