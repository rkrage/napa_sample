# Napa Sample Application

A sample application using the Napa framework and JSON web token authentication.

## Setup

Make sure MySQL is installed and the credentials are correct in the database.yml file.

```sh
bundle
bundle exec rake db:reset
RACK_ENV=test bundle exec rake db:reset
```

## Running the server

```sh
bundle exec napa s
```

## Running the tests

```sh
bundle exec rspec spec
```