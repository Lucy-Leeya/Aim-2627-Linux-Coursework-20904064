#!/bin/bash
# Q7：读取 input/remote.env，生成 ssh_config，用 SSH 和 SCP 获取远程数据。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

# 读取环境变量
source "$input/remote.env"

# 1. 生成 ssh_config 文件 (权限 600)
CONFIG_FILE="$output/ssh_config"
cat > "$CONFIG_FILE" << EOF
Host aim-sentry
    HostName $HOST
    Port $PORT
    User $REMOTE_USER
    IdentityFile "$KEY_PATH"
    UserKnownHostsFile "$KNOWN_HOSTS"
    IdentitiesOnly yes
    StrictHostKeyChecking yes
    BatchMode yes
EOF
chmod 600 "$CONFIG_FILE"

# 2. 通过 SSH 执行 whoami，保存结果
ssh -F "$CONFIG_FILE" aim-sentry whoami > "$output/remote-user.txt"

# 3. 使用 SCP 下载远端日志
mkdir -p "$output/received"
scp -F "$CONFIG_FILE" "aim-sentry:$REMOTE_LOG" "$output/received/errors.log"

exit 0
