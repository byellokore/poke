# Pokemon test api

Ruby version 2.7.1, Rails 6.0.3.

##### [API DOC Postman](https://documenter.getpostman.com/view/11451353/Szt5fWFc?version=latest#d4289833-44a1-4b8a-b67d-00b3bffa4742)


### External gems:   

* [rspec-rails](https://github.com/rspec/rspec-rails) 
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot) fixtures replacement.
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - Database cleaner.
* [pagy](https://github.com/ddnexus/pagy) - Pagination with HTTP [Headers](http://ddnexus.github.io/pagy/extras/headers).
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi) - Api Serialization.

### Database 

* Sqlite for development, for production environment I would go with Postgresql. 

* pokemon.csv is available at /lib/seeds,
```ruby
# seeds.rb will add pokemons.csv data
rails db:setup
```
### Dockerfile & docker-compose.yml

* To run the without issues.


## Tests

* RSpec 33 examples[Model Spec, Request Spec & Routing Spec]
