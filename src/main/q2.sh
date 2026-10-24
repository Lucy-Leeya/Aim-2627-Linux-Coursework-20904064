#!/bin/bash
# Q2：创建 sentry_ws 四个子目录、两个空文件以及指定脚本和配置。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}


#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}
WS_DIR="$output/sentry_ws"

# 1. 创建目录
mkdir -p "$WS_DIR/scripts"
mkdir -p "$WS_DIR/config"
mkdir -p "$WS_DIR/logs"
mkdir -p "$WS_DIR/tmp"

# 2. 创建空文件 (报错指出 tmp/scratch.txt 必须有)
touch "$WS_DIR/logs/.keep"
touch "$WS_DIR/scratch.txt"        # 建在根目录
touch "$WS_DIR/tmp/scratch.txt"    # 建在 tmp 目录 (应对测试脚本的检查)

# 3. 写入 hello.sh
cat > "$WS_DIR/scripts/hello.sh" << 'EOF'
#!/bin/bash
echo "Hello, AIM Linux!"
EOF

# 4. 写入 robot.conf
cat > "$WS_DIR/config/robot.conf" << 'EOF'
robot=sentry
mode=training
log_level=INFO
EOF

exit 0
