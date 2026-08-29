#!/bin/sh
set -eu

config_file=/tmp/mysqld-exporter.cnf

umask 077
printf '[client]\nuser=%s\npassword=%s\nhost=db\nport=3306\n' \
  "$MARIADB_MONITOR_USER" "$MARIADB_MONITOR_PASSWORD" > "$config_file"
trap 'rm -f "$config_file"' EXIT

exec /bin/mysqld_exporter --config.my-cnf="$config_file" "$@"
