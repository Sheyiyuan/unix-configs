#!/usr/bin/env bash
# niri msg action screenshot && sleep 3 && wl-paste | satty -f -S

# 声明一个变量，其值为根据 wl-paste 输出的当前剪贴板的数据计算出的 hash
CLIP_NOW=$(wl-paste | sha1sum)

# 启动 niri 截图
niri msg action screenshot

while [ "$(wl-paste | sha1sum)" = "$CLIP_NOW" ]; do
sleep .05
done

# 将新的剪贴板内容传递给 satty 打开
wl-paste | satty -f -
