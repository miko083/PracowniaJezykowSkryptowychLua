import config from require "lapis.config"
config "development", ->
  postgres ->
    host "127.0.0.1"
    user "lapis"
    password "lapis123"
    database "lapis-db"