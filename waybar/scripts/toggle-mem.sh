#!/bin/bash
# 切换显示格式

CACHE_FILE="$HOME/.cache/monitor_format"

if [[ -f "$CACHE_FILE" ]]; then
    MODE=$(cat "$CACHE_FILE")
else
    MODE=0
fi

MODE=$(( (MODE + 1) % 2 ))
echo "$MODE" > "$CACHE_FILE"
