#!/bin/bash
# Q3：复制素材、备份配置、移动草稿、删除 tmp、设定权限并直接运行 hello.sh。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

WS_DIR="$output/sentry_ws"

mkdir -p "$WS_DIR/scripts" "$WS_DIR/config" "$WS_DIR/backup" "$WS_DIR/archive"

cp "$input/hello.sh" "$WS_DIR/scripts/hello.sh"
cp "$input/robot.conf" "$WS_DIR/config/robot.conf"
cp "$input/draft.conf" "$WS_DIR/config/draft.conf"

cp "$WS_DIR/config/robot.conf" "$WS_DIR/backup/robot.conf"

mv "$WS_DIR/config/draft.conf" "$WS_DIR/archive/draft.conf.old"

rm -rf "$WS_DIR/tmp"

chmod 750 "$WS_DIR/scripts/hello.sh"
chmod 640 "$WS_DIR/config/robot.conf"

bash "$WS_DIR/scripts/hello.sh" > "$output/hello-output.txt"

exit 0
