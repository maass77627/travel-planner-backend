require "bundler/setup"
require "sinatra/activerecord"

set :database, {
  adapter: "sqlite3",
  database: "db/development.sqlite3"
}