#!/bin/bash
# Q5：运行 launch.env 给定的启动前检查，保存 stdout/stderr、真实退出码和诊断报告。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

source "$input/launch.env"

set +e
bash "$LAUNCH_TOOL" "$MODEL_PATH" "$CAMERA_PATH" > "$output/stdout.log" 2> "$output/stderr.log"
EXIT_CODE=$?
set -e

echo "$EXIT_CODE" > "$output/exit-code.txt"

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "result=SUCCESS" > "$output/report.txt"
    echo "exit_code=0" >> "$output/report.txt"
    echo "reason=NONE" >> "$output/report.txt"
elif [ "$EXIT_CODE" -eq 10 ]; then
    echo "result=FAILED" > "$output/report.txt"
    echo "exit_code=10" >> "$output/report.txt"
    echo "reason=MODEL_MISSING" >> "$output/report.txt"
elif [ "$EXIT_CODE" -eq 20 ]; then
    echo "result=FAILED" > "$output/report.txt"
    echo "exit_code=20" >> "$output/report.txt"
    echo "reason=CAMERA_DENIED" >> "$output/report.txt"
fi

exit 0
