# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Docker Compose
You need to install docker-compose before run project. https://docs.docker.com/compose/install/

* Ruby version

## Database creation & initialization
You need to create database and run migrations

```bash
docker compose run web rake db:create db:migrate
```

## How to run the test suite
We will run the test suite via docker compose.

```bash
docker compose run web bundle exec rspec
```

## Start Application
The database need to be created and migrated already before we init the application.

```bash
docker compose up --build
```
