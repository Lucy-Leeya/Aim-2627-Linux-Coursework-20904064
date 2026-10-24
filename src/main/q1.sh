#!/bin/bash
# Q1：定位 handover，读取隐藏编号和欢迎文本。输出 location.txt、robot-id.txt、welcome.txt。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

# 1. 进入 handover 保存路径
cd "$input/handover"
pwd > "$output/location.txt"

# 2. 动态查找并读取 .robot-id (防止它不在预期的位置)
ROBOT_FILE=$(find "$input" -name ".robot-id" | head -n 1)
if [ -n "$ROBOT_FILE" ]; then
    cat "$ROBOT_FILE" > "$output/robot-id.txt"
fi

# 3. 动态查找并读取 welcome.txt (防止它不在 handover 里面)
WELCOME_FILE=$(find "$input" -name "welcome.txt" | head -n 1)
if [ -n "$WELCOME_FILE" ]; then
    cat "$WELCOME_FILE" > "$output/welcome.txt"
fi

exit 0
