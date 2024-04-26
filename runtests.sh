#!/usr/bin/env sh

# run tests against all supported databases using tox
# postgres / mysql run via docker
# sqlite (default) runs against local database file (database.db)
# use pyenv or similar to install multiple python instances

export DJANGO_SETTINGS_MODULE=settings

export IMPORT_EXPORT_POSTGRESQL_USER=pguser
export IMPORT_EXPORT_POSTGRESQL_PASSWORD=pguserpass

export IMPORT_EXPORT_MYSQL_USER=mysqluser
export DB=sqlite
export DB_DATABASE=mydatabase
export DB_USERNAME=myuser
export DB_PASSWORD=mypassword

docker-compose up -d

while ! docker exec db_container sqlite3 --header --column /path/to/sqlite.db ".tables"; do
    sleep 1
done

npm test

export DB=mysql
export DB_DATABASE=mydatabase
export DB_USERNAME=myuser
export DB_PASSWORD=mypassword

docker-compose up -d

while ! docker exec db_container mysql -u myuser -pmypassword -e "SHOW TABLES;" mydatabase; do
    sleep 1
done

npm test

export DB=postgresql
export DB_DATABASE=mydatabase
export DB_USERNAME=myuser
export DB_PASSWORD=mypassword

docker-compose up -d

while ! docker exec db_container psql -U myuser -d mydatabase -c '\dt'; do
    sleep 1
done

npm test

echo "removing local database instances"
docker compose -f tests/docker-compose.yml down -v
