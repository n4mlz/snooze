#!/bin/sh
set -eu

mariadb \
  --protocol=tcp \
  --host=db \
  --user=root \
  --password="${MARIADB_ROOT_PASSWORD}" \
  --execute="
    CREATE USER IF NOT EXISTS '${MARIADB_MONITOR_USER}'@'%' IDENTIFIED BY '${MARIADB_MONITOR_PASSWORD}';
    GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO '${MARIADB_MONITOR_USER}'@'%';
    FLUSH PRIVILEGES;
  "
