#!/bin/bash
# 性能监测脚本：显示 CPU、内存和显存使用

CACHE_FILE="$HOME/.cache/monitor_format"
USE_GB=false

if [[ -f "$CACHE_FILE" ]]; then
    MODE=$(cat "$CACHE_FILE")
    if [[ "$MODE" == "1" ]]; then
        USE_GB=true
    fi
fi

# CPU 使用率
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
if [[ -z "$CPU" ]]; then
    CPU=0
fi

# 内存使用 (处理中文locale)
MEM_TOTAL=$(free -h | awk '/^内存：/ {print $2}')
MEM_USED=$(free -h | awk '/^内存：/ {print $3}')
MEM_PERCENT=$(free | awk '/^Mem:|^内存：/ {printf "%.0f", ($3/$2)*100}')

# 显存使用
GPU_USED=$(cat /sys/class/drm/card1/device/mem_info_vram_used 2>/dev/null)
GPU_TOTAL=$(cat /sys/class/drm/card1/device/mem_info_vram_total 2>/dev/null)
if [[ -n "$GPU_USED" ]] && [[ -n "$GPU_TOTAL" ]]; then
    GPU_USED_MB=$((GPU_USED / 1024 / 1024))
    GPU_TOTAL_MB=$((GPU_TOTAL / 1024 / 1024))
    GPU_PERCENT=$((GPU_USED * 100 / GPU_TOTAL))
else
    GPU_USED_MB=0
    GPU_TOTAL_MB=0
    GPU_PERCENT=0
fi

# 根据模式显示
if [[ "$USE_GB" == "true" ]]; then
    MEM_DISPLAY="${MEM_USED}"
    GPU_DISPLAY="${GPU_USED_MB}MB"
else
    MEM_DISPLAY="${MEM_PERCENT}%"
    GPU_DISPLAY="${GPU_PERCENT}%"
fi

TOOLTIP="CPU: ${CPU}%\n内存: ${MEM_USED} / ${MEM_TOTAL} (${MEM_PERCENT}%)\n显存: ${GPU_USED_MB}MB / ${GPU_TOTAL_MB}MB (${GPU_PERCENT}%)"

printf '{"text": " %s   %s  󰢮 %s", "tooltip": "%s"}\n' "$CPU%" "$MEM_DISPLAY" "$GPU_DISPLAY" "$TOOLTIP"
