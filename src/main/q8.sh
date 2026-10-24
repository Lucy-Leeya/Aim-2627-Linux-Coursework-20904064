#!/bin/bash
# Q8：repair 时识别并停止采集器、修复 HTTP 服务；cleanup 时停止修复后的服务。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

action=${3:-repair}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

action=${3:-repair}
source "$input/process.env"
source "$input/server.conf"

if [ "$action" = "repair" ]; then
    PID_INFO=$(ps -p "$TARGET_PID" -o pid=,user=,state=,args= || true)
    if [ -n "$PID_INFO" ]; then
        PID=$(echo "$PID_INFO" | awk '{print $1}')
        USER=$(echo "$PID_INFO" | awk '{print $2}')
        STATE=$(echo "$PID_INFO" | awk '{print $3}')
        CMD=$(echo "$PID_INFO" | cut -d' ' -f4-)
        {
            echo "pid=$PID"
            echo "user=$USER"
            echo "state=$STATE"
            echo "command=$CMD"
        } > "$output/process.txt"
    fi

    grep -E "TICK|START" "$WORKER_LOG" | grep "$TARGET_TOKEN" | head -n 5 > "$output/collector-sample.log" || true

    kill -15 "$TARGET_PID" || true
    for i in {1..10}; do
        if ! kill -0 "$TARGET_PID" 2>/dev/null; then break; fi
        sleep 0.2
    done

    kill -15 "$SERVICE_PID" || true
    sleep 1

    NEW_CONF="$output/server.conf"
    echo "bind=127.0.0.1" > "$NEW_CONF"
    echo "port=$TARGET_PORT" >> "$NEW_CONF"
    echo "route=/status" >> "$NEW_CONF"

    mkdir -p "$output/service"
    bash "$START_TOOL" "$NEW_CONF" "$output/service" || true

     # 7. 测试 HTTP
 for i in {1..10}; do
     HTTP_CODE=$(curl -s -o "$output/http-body.txt" -w "%{http_code}" "http://127.0.0.1:$TARGET_PORT/status" 2>/dev/null || true)
     if [ "$HTTP_CODE" = "200" ]; then
         echo "$HTTP_CODE" > "$output/http-status.txt"
         break
     fi
     sleep 0.5
 done

elif [ "$action" = "cleanup" ]; then
    if [ -f "$output/service/pid" ]; then
        NEW_PID=$(cat "$output/service/pid")
        kill -15 "$NEW_PID" || true
    fi
fi

exit 0
