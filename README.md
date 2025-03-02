# malo_search
A simple Rails app for searching articles by title, content, and tags. Users can enter free text to find relevant articles, displaying results with images and titles. Implements basic data filtering and storage while ensuring only valid tags are saved

## Initialize the app

Install the gems and initialize the database with the data of the `articles_simplified.json`

```sh
bundle install
rails db:create
rails db:migrate
rails db:seed
```

To run the tests: `bundle exec rspec`
