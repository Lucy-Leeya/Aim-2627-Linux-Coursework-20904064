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

# 1. 创建四个目录
mkdir -p "$WS_DIR/scripts"
mkdir -p "$WS_DIR/config"
mkdir -p "$WS_DIR/logs"
mkdir -p "$WS_DIR/tmp"

# 2. 创建两个空文件
touch "$WS_DIR/logs/.keep"
touch "$WS_DIR/scratch.txt"

# 3. 纯手写生成 hello.sh (不要用 cp)
cat > "$WS_DIR/scripts/hello.sh" << 'EOF'
#!/bin/bash
echo "Hello, AIM Linux!"
EOF

# 4. 纯手写生成 robot.conf (不要用 cp)
cat > "$WS_DIR/config/robot.conf" << 'EOF'
robot=sentry
mode=training
log_level=INFO
EOF

exit 0
