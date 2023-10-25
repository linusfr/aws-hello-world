#!/bin/bash
# shellcheck disable=SC2154

cat >index.html <<EOF
<h1>Hello, World from ${cluster_name}</h1>
EOF

nohup busybox httpd -f -p "${server_port}" &
