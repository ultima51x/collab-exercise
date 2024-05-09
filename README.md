# Playlists

This is a playlist app for a take home coding exercise.

## Implementation Notes

* This was implemented using Ruby on Rails.  The frontend is mostly rendered by the server.  This utilizes bootstrap 5 for some of its components and styling.  I used features that are packaged with Rails 7.  HAML is mostly used instead of ERB.
* The interactive fatures utilizes Stimulus <https://stimulus.hotwired.dev/> and Turbo <https://turbo.hotwired.dev/> which are included with Rails by default.
* Shopfiy Draggable is used for sorting functionality <https://github.com/Shopify/draggable/tree/main/src/Sortable>.
* JavaScript dependencies are managed using rails importmaps functionality.  They point to files hosted by CDNs.
* I used a linter for Ruby called standard.  I didn't use a linter for the JavaScript.
* Some of the functionality was inspired by looking at YouTube, specifically with adding/removing videos from playlists from the videos page.
* Search on titles was implemented using full text search.  On a bigger project, I'd probably opt to use <https://github.com/Casecommons/pg_search>.
* I did not work on pagination, but I'd probably use something like kaminari.
* This uses ActiveJob for fetching videos.  I did not set up ActiveJob to have a real queue adapter.  Development uses the default: `async`.
* This project was setup using `rails new --skip-action-mailer --skip-action-mailbox --skip-action-cable --skip-test --database=postgresql playlists`

## Versions

* Ruby 3.3.0
* Rails 7.1
* PostgreSQL is required.  This was programmed using version 13.

## Data Models

* Users - I decided to use a dummy users model because this felt unnatural to me without one. `rake db:seed` creates a dummy one that will always be loaded.
* Playlists
* Video
* PlaylistEntry - a join model between Playlist and Video.  Also has an ordering attribute named `seq`

## Setup

```ruby
# The database will be assumed to be named: playlists_development and playlists_test
rake db:create
rake db:migrate
rake db:seed  # needed because it creates one fake user for the app to run.
```

## Usage

* The app is accessible using <http://localhost:3000> assuming using the default Rails port.
* Click on Videos
* Initially no videos will be present.
* To load videos, press Refresh Videos
* Refresh the page after a couple seconds to see videos.

## Tests

There are very basic sanity tests included.  Most of them only test HTTP codes.  Tests can be run using:

```sh
bundle exec rspec
```
