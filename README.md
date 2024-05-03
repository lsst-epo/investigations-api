# Formal Education Investigations Craft CMS

## Set up and run the project locally

#### Make scripts

---
To list the local databases for this project, first bring up the postgres container if it's not already up:

`docker-compose -f docker-compose-local-db.yml up --build postgres`

Then, list your local databases:

`make db-list`

---
To list the databases sitting around in the `prod` environment so that you can know which `dbname` to supply in `make cloud-db-export dbname=(which db you want to export)`:

`make cloud-db-list`

---
To export a `prod` database to the `gs://release_db_sql_files/investigations/` bucket:

`make cloud-db-export dbname=prod_db`

* The argument `dbname` is required and should be one of the databases listed from `make cloud-db-list`
* You will need to go into the `prod` GCP project in the Google Cloud Storage resource to find the DB dump file
* Once you download the DB dump file, move it to the `./db/` folder
---
To provision a new local database, first bring up the postgres container if it's not already up:

`docker-compose -f docker-compose-local-db.yml up --build postgres`

Ensure that the dump file is located within `./db/`, then run:

`make local-db dbname=my_new_local_db dbfile=prod.sql`

* The argument `dbname` is required and will be the name of the newly created database
* The argument `dbfile` is required and should be the name of the DB file to recreate, this file _must_ be in the `./db/` folder
---

<br>
<br>
<br>
<br>
<br>

#### Deprecated workflow

0. Uncomment the `COPY` line in `./db/Dockerfile`
1. Install [Docker](https://docs.docker.com/get-docker/)
2. Clone this repository
3. Add a .env file (based on .env.sample) and provide values appropriate to your local dev environment
4. If running for the first time, docker will create a local DB based on the `db.sql` file in `/db`
5. You'll need to install php packages locally. You may do so with your local composer, but you can also run it all through docker: `docker run -v ${PWD}/api:/app composer install`
6. Build and bring up containers for the first time:

```shell
docker-compose -f docker-compose-local-db.yml up --build
```

7. Subsequent bringing up of containers you've already built:
```shell
docker-compose -f docker-compose-local-db.yml up
```
8. Go to <http://localhost:8080/admin> to administer the site
9. Default admin username and password, as included in the db.sql file, is `example / password`

These and other most used docker commands for bringing containers up/down are aliased in a Makefile:
 * `make start` is equivalent to `docker-compose -f docker-compose-local-db.yml up --build`
 * `make clean` is equivalent to `docker system prune -f && docker volume prune -f`
 * `make clean-images` is equivalent to `docker images prune`

#### Useful docker commands for local development

1. Cleaning house: `docker volume prune` `docker system prune`
2. Spin stuff down politely: `docker-compose -f docker-compose-local-db.yml down`
3. Peek inside your running docker containers:
  * `docker container ls`
  * `docker exec -it <CONTAINER-ID> /bin/sh`
  * and then, for instance, to look at DB `psql -d craft -U craft`
4. To rebuild images and bring up the containers: `docker-compose -f docker-compose-local-db.yml up --build`
5. When you need to do composer stuff: `docker run -v ${PWD}/api:/app composer <blah>`
6. After ssh-ing into a live GAE instance, by way of the GCP console interface, you can ssh into a running container: `docker exec -ti gaeapp sh`
7. When working locally, in order to ensure the latest docker `craft-base-image` is used: `docker pull us-central1-docker.pkg.dev/skyviewer/public-images/craft-base-image`














