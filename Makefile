SHELL := /bin/sh
start:
	docker-compose -f docker-compose-local-db.yml up --build

clean:
	docker system prune -f && docker volume prune -f

clean-images:
	docker images prune

# Requires argument `dbname` to specify the name of the new DB, usage: `make local-db dbname=my_db`
local-db:
	cd db && docker exec --workdir / investigations-api-postgres-1 psql -U craft -c "create database $(dbname);"
	cd db && docker exec --workdir / investigations-api-postgres-1 psql -U craft -d $(dbname) -f inv_mar.sql
	echo "\n\n\n\nDon't forget to update your docker-compose-local-db.yaml with the DB name: $(dbname)"

db-list:
	cd db && docker exec --workdir / investigations-api-postgres-1 psql -U craft -c "SELECT (pg_stat_file('base/'||oid ||'/PG_VERSION')).modification, datname FROM pg_database;"

cloud-db-list:
	curl https://us-central1-edc-prod-eef0.cloudfunctions.net/sql-helper/databases\?action\=list\&project\=investigations

# Requires argument `dbname` to specify the name of the DB to be exported, usage: `make cloud-db-export dbname=prod_db`
cloud-db-export:
	curl https://us-central1-edc-prod-eef0.cloudfunctions.net/sql-helper/databases\?action\=export\&database\=$(dbname)\&project\=investigations