# Database Configuration

---

### To use a local db

1. To list the local databases for this project, first bring up the postgres container if it's not already up:

`docker-compose -f docker-compose-local-db.yml up --build postgres`

2. Then, list your local databases:

`make db-list`

3. To list the databases sitting around in the `prod` environment so that you can know which `dbname` to supply in `make cloud-db-export dbname=(which db you want to export)`:

`make cloud-db-list`

4. To export a `prod` database to the `gs://release_db_sql_files/investigations/` bucket:

`make cloud-db-export dbname=prod_db`

* The argument `dbname` is required and should be one of the databases listed from `make cloud-db-list`
* You will need to go into the `prod` GCP project in the Google Cloud Storage resource to find the DB dump file
* Once you download the DB dump file, move it to the `./db/` folder

4. To provision a new local database, first bring up the postgres container if it's not already up:

`docker-compose -f docker-compose-local-db.yml up --build postgres`

5. Ensure that the dump file is located within `./db/`, then run:

* Once you download the DB dump file, move it to the `./db/` folder

6. To recreate a local DB from a dump file located within `./db/`:

`make local-db dbname=my_new_local_db dbfile=prod.sql`

* The argument `dbname` is required and will be the name of the newly created database
* The argument `dbfile` is required and should be the name of the DB file to recreate, this file _must_ be in the `./db/` folder

---

### To connect to the dev Cloud SQL DB Instance

1. Connect to the `dev` Cloud SQL proxy: `gcloud compute ssh db-client-1 --project=skyviewer --zone=us-central1-a -- -L 127.0.0.1:5432:10.109.178.3:5432`
3. Set the database password in the `DB_PASSWORD` environment variable locally, and set the site's security key to the `SECURITY_KEY` env var, and any other environment variables that need to be.
4. Bring the Docker compose file up:

    ```shell
    docker-compose up
    ```

5. Go to <http://localhost:8080/admin> to administer the site

---

### To connect to the integration Cloud SQL DB Instance

1. Connect to the `int` Cloud SQL proxy: `gcloud compute ssh sql-proxy-1 --project=edc-int-6c5e --zone=us-central1-a -- -t -L 0.0.0.0:5432:10.22.151.12:5432`
3. Set the database password in the `DB_PASSWORD` environment variable locally, and set the site's security key to the `SECURITY_KEY` env var, and any other environment variables that need to be.
4. Bring the Docker compose file up:

    ```shell
    docker-compose -f docker-compose.yml -f integration.yml up
    ```

5. Go to <http://localhost:8080/admin> to administer the site