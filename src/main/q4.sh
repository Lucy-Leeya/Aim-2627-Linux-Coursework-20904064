#!/bin/bash
# Q4：合并日志，按级别提取，保存首尾片段并统计错误行数。
# 完整接口与验收规格见 Problem.pdf。只修改本文件，不修改测试或工具。
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

#!/bin/bash
set -eu
input=${1:?需要输入目录}
output=${2:?需要输出目录}

# 1. 按顺序拼接 boot.log 和 run.log
cat "$input/boot.log" "$input/run.log" > "$output/all.log"

# 2. 提取级别字段为 ERROR 的完整行
# 加 || true 是为了防止日志里没有 ERROR 时 grep 报错导致脚本退出
grep "^ERROR " "$output/all.log" > "$output/errors.log" || true

# 3. 提取级别字段为 WARN 或 ERROR 的完整行
grep -E "^(WARN|ERROR) " "$output/all.log" > "$output/attention.log" || true

# 4. 保存 all.log 的最后 5 行
tail -n 5 "$output/all.log" > "$output/recent.log"

# 5. 保存 errors.log 的最前 3 行
head -n 3 "$output/errors.log" > "$output/first-errors.log"

# 6. 统计 errors.log 的行数 (wc -l 会带空格，用 tr 删掉，保证只有数字)
wc -l < "$output/errors.log" | tr -d ' ' > "$output/error-count.txt"

exit 0
