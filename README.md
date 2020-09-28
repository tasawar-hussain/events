# README

Ruby on Rails api application for group event

## Project Setup
### Prerequisites
- [Ruby](https://www.ruby-lang.org/en/) 2.7.0
- [Bundler](https://bundler.io/) 2.1.4
- [PostgreSQL](https://www.postgresql.org/) 10.11
- [Yarn](https://yarnpkg.com/) 1.22
- [Rvm](https://rvm.io/) - optional

### Development
1. Install ruby 2.7 via rvm or any other ruby version managers of your choice

2. Install bundler
    ```bash
    gem install bundler:2.1.4
    ```
3. Install Postgres 10.11
    For Mac only: [Postgres.app](https://postgresapp.com/)

4. Install dependencies
    ```bash
    bundle install
    ```
5. Setup database and migrations
    ```bash
    rails db:setup
    ```
6. Start server
    ```bash
    rails s
    ```

6. Run specs
    ```bash
    rspec spec/
    ```
