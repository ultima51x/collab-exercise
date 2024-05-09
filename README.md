# Playlists

This is a playlist app for a take home exercise.

This was implemented using Rails server side templating and Bootstrap 5.  I decided to try to use Rails importmaps with Sprockets.

I decided to lint the code using ruby standard.

## Versions

* This was implemented using Ruby 3.3.0 and Rails 7.1
* PostgreSQL is required.  This was programmed using version 13.

## Data Models

* Users - I decided to use a dummy users model because this felt unnatural to me without one. `rake db:seed` creates a dummy one that will always be loaded.
* Playlists
* Video
* PlaylistEntry - a join model between Playlist and Video.  Also has an ordering attribute named `seq`

## Instructions

Make sure to run `rake db:seed` because it creates one fake user for the app to run.

## Tests

Tests can be run

```
bundle exec rspec
```

## How this was setup

I set up a new rails project using

```
rails new --skip-action-mailer --skip-action-mailbox --skip-action-cable --skip-test --database=postgresql playlists
```

I did not set up ActiveJob to have a real queue adapter.  Development uses the default: `async`.


## TODO for docs

Things you may want to cover:

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
