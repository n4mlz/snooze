#!/bin/sh
set -eu

export DATA_SOURCE_NAME="${MARIADB_MONITOR_USER}:${MARIADB_MONITOR_PASSWORD}@(db:3306)/"
exec /bin/mysqld_exporter "$@"
