# Craft CMS Starter Project

## Generating a New Project from this Repo

If you are viewing this README on Github you will see a green button above with the text "Use this template". Click that button to create a brand new repository for your new project. This README, along with the files/folders, will be copied over to the new repo and can be used as instructions on how to get up-and-going fairly quickly.

# Craft headless CMS Backend/API

Headless Craft headless CMS backend intended to be used with the Rubin EPO [next-template](https://github.com/lsst-epo/next-template/).

This project was created with Docker version 20.10.5.

## Set up and run the project locally

#### Make scripts

---
To list your local DBs:

`make db-list`

---
To list the databases sitting around in the `prod` environment:

`make cloud-db-list`

---
To export a `prod` database to the `gs://release_db_sql_files/investigations/` bucket:

`make cloud-db-export dbname=prod_db`

* The argument `dbname` is required and should be one of the databases listed from `make cloud-db-list`
* Once you download the DB dump file, move it to the `./db/` folder
---
To recreate a local DB from a dump file located within `./db/`:

`make local-db dbname=my_new_local_db dbfile=prod.sql`

* The argument `dbname` is required and will be the name of the newly created database
* The argument `dbfile` is required and should be the name of the DB file to recreate, this file _must_ be in the `./db/` folder
---
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

#### Local Database notes

If you completed the above steps you may have noticed some SQL commands in the log output.

This is because by default the DB snapshot bundled with this repo in /db will execute upon bringing up the docker-compose file.

#### How to create a dump of your local DB

1. Containers need to be running, we're going to ssh into the postgres one:
  * `docker container ls`
  * `docker exec -it <POSTGRES_CONTAINER_ID> /bin/sh`
2. Create the dump file within the container:
  * `pg_dump -U craft <CRAFT_DATABASE_NAME> >> whatever_name_you_want.sql`
3. Retrieve & save the dump file to your local:
  * Open a new terminal window
  * `docker cp <POSTGRES_CONTAINER_ID>:/path/to/whatever_name_you_want.sql /local/path/to/whatever_name_you_want.sql`




















