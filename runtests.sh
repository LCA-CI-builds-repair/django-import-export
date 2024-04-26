#!/usr/bin/env sh
# Set the Django settings module
export DJANGO_SETTINGS_MODULE=settings

# Set environment variables for PostgreSQL and MySQL
export IMPORT_EXPORT_POSTGRESQL_USER=pguser
export IMPORT_EXPORT_POSTGRESQL_PASSWORD=pguserpass
export IMPORT_EXPORT_MYSQL_USER=mysqluser
export IMPORT_EXPORT_MYSQL_PASSWORD=mysqluserpass

# Start local database instances using Docker
echo "Starting local database instances"
docker compose -f tests/docker-compose.yml up -d

# Wait for database initialization
echo "Waiting for database initialization"
sleep 45

# Run tests using SQLite
echo "Running tests (SQLite)"
tox

# Run tests using MySQL
echo "Running tests (MySQL)"
export IMPORT_EXPORT_TEST_TYPE=mysql-innodb
tox

# Run tests using PostgreSQL
echo "Running tests (PostgreSQL)"
export IMPORT_EXPORT_TEST_TYPE=postgres
tox

# Remove local database instances
echo "Removing local database instances"
docker compose -f tests/docker-compose.yml down -v
