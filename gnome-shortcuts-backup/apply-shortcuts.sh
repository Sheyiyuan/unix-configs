#!/bin/bash

# ============================================
# GNOME 快捷键导入脚本
# 功能：备份当前快捷键并应用新的快捷键配置
# ============================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检查 dconf 是否可用
check_dconf() {
    if ! command -v dconf &> /dev/null; then
        log_error "dconf 未安装，请先安装 dconf-cli"
        log_info "安装方法："
        echo "  Ubuntu/Debian: sudo apt install dconf-cli"
        echo "  Fedora: sudo dnf install dconf"
        echo "  Arch: sudo pacman -S dconf"
        exit 1
    fi
}

# 检查是否在 GNOME 环境中
check_gnome() {
    if [ -z "$XDG_CURRENT_DESKTOP" ]; then
        log_warn "无法检测桌面环境"
        read -p "是否继续？(y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    elif [[ ! "$XDG_CURRENT_DESKTOP" =~ GNOME|gnome|Ubuntu|ubuntu ]]; then
        log_warn "当前桌面环境: $XDG_CURRENT_DESKTOP (不是 GNOME)"
        read -p "是否继续？(y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# 备份当前快捷键配置
backup_current() {
    BACKUP_DIR="$SCRIPT_DIR/backups"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="$BACKUP_DIR/shortcuts_$TIMESTAMP.tar.gz"

    mkdir -p "$BACKUP_DIR"

    log_info "备份当前快捷键配置..."

    # 备份媒体键
    dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > "$BACKUP_DIR/media-keys_$TIMESTAMP.ini" 2>/dev/null || true

    # 备份窗口管理器快捷键
    dconf dump /org/gnome/desktop/wm/keybindings/ > "$BACKUP_DIR/wm-keybindings_$TIMESTAMP.ini" 2>/dev/null || true

    # 备份桌面快捷键
    dconf dump /org/gnome/desktop/peripherals/keyboard/ > "$BACKUP_DIR/keyboard_$TIMESTAMP.ini" 2>/dev/null || true

    # 打包备份
    if [ -f "$BACKUP_DIR/media-keys_$TIMESTAMP.ini" ] || [ -f "$BACKUP_DIR/wm-keybindings_$TIMESTAMP.ini" ]; then
        tar -czf "$BACKUP_FILE" -C "$BACKUP_DIR" \
            "media-keys_$TIMESTAMP.ini" \
            "wm-keybindings_$TIMESTAMP.ini" \
            "keyboard_$TIMESTAMP.ini" 2>/dev/null || true

        # 清理临时文件
        rm -f "$BACKUP_DIR"/*_$TIMESTAMP.ini

        log_success "备份已保存到: $BACKUP_FILE"
    else
        log_warn "没有找到需要备份的配置"
    fi
}

# 应用快捷键配置
apply_shortcuts() {
    MEDIA_KEYS_FILE="$SCRIPT_DIR/media-keys.ini"
    WM_KEYS_FILE="$SCRIPT_DIR/wm-keybindings.ini"

    # 应用媒体键配置
    if [ -f "$MEDIA_KEYS_FILE" ]; then
        log_info "应用媒体键配置..."

        # 创建临时文件，替换路径
        TEMP_FILE=$(mktemp)
        sed "s|/home/syy|$HOME|g" "$MEDIA_KEYS_FILE" > "$TEMP_FILE"

        # 导入配置
        dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$TEMP_FILE"

        # 清理临时文件
        rm -f "$TEMP_FILE"

        log_success "媒体键配置已应用"
    else
        log_warn "未找到媒体键配置文件: $MEDIA_KEYS_FILE"
    fi

    # 应用窗口管理器快捷键配置
    if [ -f "$WM_KEYS_FILE" ]; then
        log_info "应用窗口管理器快捷键配置..."
        dconf load /org/gnome/desktop/wm/keybindings/ < "$WM_KEYS_FILE"
        log_success "窗口管理器快捷键配置已应用"
    else
        log_warn "未找到窗口管理器快捷键配置文件: $WM_KEYS_FILE"
    fi
}

# 显示帮助信息
show_help() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  --backup-only    仅备份当前配置，不应用新配置"
    echo "  --apply-only     仅应用新配置，不备份当前配置"
    echo "  --no-backup      跳过备份步骤"
    echo "  --help           显示帮助信息"
    echo ""
    echo "示例:"
    echo "  $0                      # 备份当前配置并应用新配置"
    echo "  $0 --backup-only        # 仅备份当前配置"
    echo "  $0 --apply-only         # 仅应用新配置"
    echo ""
    echo "文件说明:"
    echo "  media-keys.ini        媒体键和自定义快捷键配置"
    echo "  wm-keybindings.ini    窗口管理器快捷键配置"
    echo "  backups/              备份文件存储目录"
    echo ""
}

# 主函数
main() {
    BACKUP=true
    APPLY=true

    # 解析参数
    for arg in "$@"; do
        case $arg in
            --backup-only)
                BACKUP=true
                APPLY=false
                shift
                ;;
            --apply-only)
                BACKUP=false
                APPLY=true
                shift
                ;;
            --no-backup)
                BACKUP=false
                shift
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                log_error "未知参数: $arg"
                show_help
                exit 1
                ;;
        esac
    done

    echo ""
    echo "=========================================="
    echo "   GNOME 快捷键配置工具"
    echo "=========================================="
    echo ""

    # 执行检查
    check_dconf
    check_gnome

    # 备份
    if [ "$BACKUP" = true ]; then
        backup_current
    fi

    # 应用
    if [ "$APPLY" = true ]; then
        apply_shortcuts
    fi

    echo ""
    echo "=========================================="
    log_success "完成！"
    echo "=========================================="
    echo ""

    if [ "$APPLY" = true ]; then
        echo "注意："
        echo "  • 部分快捷键可能需要注销并重新登录才能生效"
        echo "  • 如果自定义快捷键不工作，请检查应用程序路径是否正确"
        echo "  • 可以使用 'dconf-editor' 图形工具查看和修改配置"
        echo ""
    fi
}

# 运行主函数
main "$@"
