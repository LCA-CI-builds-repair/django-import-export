#!/usr/bin/env bash
set -e

mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
# Grant all privileges on the test_import_export database to the specified MySQL user
  GRANT ALL PRIVILEGES ON test_import_export.* to '$MYSQL_USER';

EOSQL