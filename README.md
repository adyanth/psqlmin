# PSQLMIN: Postgres + Webmin

All I wanted was a simple management UI for postgres where I can add tables and give users permissions on those tables.
My usecase was to run a postgres server on my NAS letting all other apps use it as a central database.

Enter `psqlmin`.

## Build

To build, run the command on the cloned repo, optionally setting the postgres version tag to use. This is only tested with ubuntu versions of postgres

```bash
docker build [--build-arg PG_VERSION=17-bullseye] -t psqlmin .
```

## Configurable `ENV` variables

The following can be overriden at runtime by setting the env vars on the container:

* `WEB_USERNAME`: Defaults to postgres. Not related to the DB
* `WEB_PASSWORD`: Defaults to postgres.
* `WEB_PORT`: Defaults to 8080

See [postgres instructions](https://hub.docker.com/_/postgres) for postgres related configuration.

## Run

Try running the container with:

```bash
docker run \
  -p 8080:8080 \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  -e WEB_USERNAME=root \
  -e WEB_PASSWORD=pass \
  -e WEB_PORT=8080 \
  -d psqlmin
```

You should be able to open [http://127.0.0.0:8080](http://127.0.0.1:8080) and login with root:pass to see and manage your databases.

