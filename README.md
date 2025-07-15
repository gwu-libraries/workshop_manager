# README

## User instructions 

(Coming soon!)

## Development Instructions

### Ruby Version and Dependencies

This application requires:
- ruby 3.2.1
- nodejs 20.12.1
- yarn 1.22.22
- postgres

These can be installed with various package managers (such as [asdf](https://github.com/asdf-vm/asdf) or [rbenv](https://github.com/rbenv/rbenv)).

To install gem dependencies, ensure you have `bundler` installed - which can usually be accomplished with `gem install bundler` if you have Ruby installed. With `bundler` installed, run `bundle install` in the repository directory.

If you run into issues related to the `pg` gem, see the instructions in `config/database.yml`. 

### .env Configuration

Make a copy of the `.env.example` file and name it `.env`, then fill in the variables with your configuration information. 

Setting a `POSTGRES_PASSWORD` is required. 

The `GMAIL_USERNAME` and `GMAIL_APP_PASSWORD` are used for sending email notifications and calendar invitations, which is configured to only be used in a `production` environment. For development and testing purposes, these can safely be left as placeholders. 

The `AWS_ACCESS_KEY`, `AWS_SECRET_KEY`, `AWS_REGION`, and `S3_BUCKET_NAME` are used for ActiveStorage in a `production` environment for document upload/download, and can also be left as placeholders for development and testing. 

### Database Creation and Initialization

To create the development and test databases, run `bundle exec rails db:create`. 

After creating the databases, run the migrations with `bundle exec rails db:migrate`. 

For development, this application comes with a `seeds.rb` file that can be used for creating dummy data by running `bundle exec rails db:seed`. This creates a facilitator account (username: `facilitator@example.com`, password: `password`) and an admin account (username: `admin@example.com`, username: `password`), as well as workshops, participants, and other example objects. 

### Test Suite

This application uses [RSpec](https://github.com/rspec/rspec-rails) for automated testing. This can be run with `bundle exec rspec`, and will be run as a Github action when a pull request is opened to the `main` branch. 

### Docker and Production Deployment

The containerized version of this application uses:
- Postgres
- Sidekiq
- Nginx
- Redis
- Application docker image

These can be built or downloaded using [Docker Compose](https://docs.docker.com/compose/install/) by running `docker-compose build` (or `docker compose build` depending on your docker compose verison).

The docker configuration is designed for a `production` environment, and requires a CA certificate and key to be generated and placed in `nginx/certs/`, named as `nginx/certs/key.pem` and `nginx/certs/certificate.pem`.

All settings in `.env` should also be completed. 

The application should then be launchable using `docker-compose up`. 
