#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    # Create a new user in PostgreSQL with the specified username and password
    CREATE USER $IMPORT_EXPORT_POSTGRESQL_USER WITH PASSWORD '$IMPORT_EXPORT_POSTGRESQL_PASSWORD';

    # Create a new database with the specified name and encoding set to UTF-8
    CREATE DATABASE $DB_NAME ENCODING 'utf-8';

    # Grant all privileges on the created database to the PostgreSQL user
    GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $IMPORT_EXPORT_POSTGRESQL_USER;

    # Allow the PostgreSQL user to create databases
    ALTER USER $IMPORT_EXPORT_POSTGRESQL_USER CREATEDB;

EOSQL