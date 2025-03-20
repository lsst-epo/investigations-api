# Formal Education Investigations Craft CMS

[![Deployed to Production](https://github.com/lsst-epo/investigations-api/actions/workflows/build-and-push.yaml/badge.svg)](https://github.com/lsst-epo/investigations-api/actions/workflows/build-and-push.yaml)

Headless Craft CMS backend for the Formal Education Investigations website.

## Set up and run the project

1. Clone the repo down
2. Create a copy of `docker-compose-local-db.sample.yaml` and name it `docker-compose-local-db.yaml`
3. Ask someone on the team for the values to fill in the `docker-compose-local.db.yaml`
4. Follow the instructions in `./db/README.md` for provisioning your local database
5. Run `docker-compose -f docker-compose-local-db.yaml up --build` to bring the Docker Compose orchestration up
6. Navigate to http://localhost:8080/admin to log in to the Craft dashboard

### Useful docker commands for local development

1. Delete errant and bloated volumes: `docker volume prune`
2. Delete stopped and unused containers, networks, and images: `docker system prune`
2. Shut down running containers gracefully: `docker-compose -f docker-compose-local-db.yml down`
3. SSH into a running container:
* `docker container ls`
* `docker exec -it <CONTAINER-ID> /bin/sh`
* If you're SSHing into a PostgreSQL container and want to enter the `psql` CLI: `psql -d craft -U craft`
5. When you need to do composer operations: `docker run -v ${PWD}/api:/app composer <require/remove> <package>`
7. When working locally, in order to ensure the latest docker `craft-base-image` is used: `docker pull us-central1-docker.pkg.dev/skyviewer/public-images/craft-base-image`

















