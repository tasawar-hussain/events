# Group Event API

####  Ruby on Rails api application for group event
### Assumptions
##### Following are the assumptions taken while implementing the test
* The event name will be unique to identify an event uniquely
* `Duration` will be in days `(1, 2,3 ...)`
* On `published: true`, only then one the `Start Date`, `End Date` and `Duration` field will be calculated  if others two are present
* `End Date` can not be in past
* `Start Date` can not exceed `End Date`
* If `Start Date` and `End Date` are on same day, it will considered as event with `1 day duration`, for exampple if `Start Date: 20-11-2020` and `End Date: 23-11-2020`, the `duration` will `days`
* After the `event` has been `published`, it can not be updated

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
7. To run swagger, enter the following url in browser:
    ```bash
    http://127.0.0.1:3000/api-docs/index.html
