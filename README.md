# Craft CMS Starter Project

## Generating a New Project from this Repo

If you are viewing this README on Github you will see a green button above with the text "Use this template". Click that button to create a brand new repository for your new project. This README, along with the files/folders, will be copied over to the new repo and can be used as instructions on how to get up-and-going fairly quickly.

# Craft headless CMS Backend/API

Headless Craft headless CMS backend intended to be used with the Rubin EPO [next-template](https://github.com/lsst-epo/next-template/).

This project was created with Docker version 20.10.5.

## Set up and run the project locally

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