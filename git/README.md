# Git 配置说明

本目录包含 Git 的全局配置文件，支持根据远程仓库 URL 自动切换用户名和邮箱。

## 目录结构

- `.gitconfig`：主配置文件（包含默认用户信息与条件包含逻辑）
- `.gitconfig-github.com.example`：GitHub 专用配置示例

## 依赖要求

- **Git 2.36+**：需要支持 `hasconfig:remote.*.url:*` 条件语法

可通过以下命令检查版本：
```sh
git --version
```

## 使用方式（推荐：软链接）

将配置文件链接到用户主目录：

```sh
ln -sf $HOME/unix-configs/git/.gitconfig $HOME/.gitconfig
```

## 多域名配置说明

主配置文件中已配置条件包含，可根据远程 URL 自动加载对应配置：

| 远程 URL | 配置文件路径 |
|---------|-------------|
| `https://github.com/**` 或 `git@github.com:*/**` | `~/.gitconfig-github.com` |
| `https://gitlab.com/**` 或 `git@gitlab.com:*/**` | `~/.gitconfig-gitlab.com` |

### 添加新域名支持

1. 创建对应的配置文件，如 `~/.gitconfig-gitee.com`：

```gitconfig
[user]
name = YourUsername
email = your@email.com
```

2. 在 `.gitconfig` 中添加条件包含：

```gitconfig
[includeIf "hasconfig:remote.*.url:https://gitee.com/**"]
    path = ~/.gitconfig-gitee.com

[includeIf "hasconfig:remote.*.url:git@gitee.com:*/**"]
    path = ~/.gitconfig-gitee.com
```

### 配置优先级

- 条件包含的配置会覆盖主配置中的默认值
- 配置文件不存在时，Git 会静默忽略，继续使用默认配置

## 主配置文件说明

| 配置项 | 说明 |
|-------|------|
| `user.name` | 默认提交作者名 |
| `user.email` | 默认提交作者邮箱 |
| `init.defaultBranch` | 新仓库默认主分支名 (main) |
| `core.editor` | 默认编辑器 (nvim) |
| `core.autocrlf` | 换行处理：提交转 LF，检出保持原样 |
| `pull.rebase` | 拉取使用 rebase 保持线性历史 |
| `fetch.prune` | 拉取时清理已删除的远程分支 |

## 常用别名

| 别名 | 命令 | 说明 |
|-----|------|------|
| `git st` | `git status -sb` | 简洁状态 |
| `git co` | `git checkout` | 切换分支/检出 |
| `git new` | `git switch -c` | 新建并切换分支 |
| `git br` | `git branch` | 分支管理 |
| `git ci` | `git commit` | 提交 |
| `git lg` | `git log --oneline --graph --decorate --all` | 图形化日志 |

## 验证配置生效

进入任意 Git 仓库后，可通过以下命令验证当前使用的配置：

```sh
# 查看当前用户配置
git config user.name
git config user.email

# 查看所有配置及来源
git config --list --show-origin
```
