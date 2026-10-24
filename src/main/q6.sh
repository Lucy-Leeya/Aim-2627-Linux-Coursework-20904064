#!/bin/bash
# Q6：将本地 Debian 包安装到 output/sysroot，运行安装后的工具。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}


#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

SYSROOT="$output/sysroot"
mkdir -p "$SYSROOT"

dpkg --root="$SYSROOT" --force-not-root --log=/dev/null -i "$input/aim-sentry-tools.deb"

"$SYSROOT/usr/bin/aim-sentry-info" > "$output/tool-output.txt"

exit 0
