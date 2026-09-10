require "sinatra"
require "sinatra/activerecord"

require_relative "./models/user"
require_relative "./models/trip"

set :database, {
  adapter: "sqlite3",
  database: "db/development.sqlite3"
}

get "/" do
  "Travel Planner API"
end