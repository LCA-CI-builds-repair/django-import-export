## Run tests againsleep 10

# Running tests with SQLite
echo "running tests (sqlite)"
tox

# Running tests with MySQL
echo "running tests (mysql)"
export IMPORT_EXPORT_TEST_TYPE=mysql
toxupported databases using tox
# Postgres / MySQL run via docker
# SQLite (default) runs against local database file (database.db)
# Use pyenv or similar to install multiple Python instances

export DJANGO_SETTINGS_MODULE=project.settingsin/env sh

# run tests against all supported databases using tox
# postgres / mysql run via docker
# sqlite (default) runs against local database file (database.db)
# use pyenv or similar to install multiple python instances

export DJANGO_SETTINGS_MODULE=settings

export IMPORT_EXPORT_POSTGRESQL_USER=pguser
export IMPORT_EXPORT_POSTGRESQL_PASSWORD=pguserpass

export IMPORT_EXPORT_MYSQL_USER=mysqluser
export IMPORT_EXPORT_MYSQL_PASSWORD=mysqluserpass

echo "starting local database instances"
docker compose -f tests/docker-compose.yml up -d

echo "waiting for db initialization"
sleep 45

echo "running tests (sqlite)"
tox

echo "running tests (mysql)"
export IMPORT_EXPORT_TEST_TYPE=mysql-innodb
tox

echo "running tests (postgres)"
export IMPORT_EXPORT_TEST_TYPE=postgres
tox

echo "removing local database instances"
docker compose -f tests/docker-compose.yml down -v
