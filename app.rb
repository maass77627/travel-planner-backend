require "sinatra"
require "sinatra/activerecord"
require "rack/cors"
require_relative "./models/user"
require_relative "./models/trip"
require_relative "./models/activity"
require "json"

set :session_secret, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-my-travel-planner-session-secret"

set :protection, except: :http_origin
enable :sessions

set :database, {
  adapter: "sqlite3",
  database: "db/development.sqlite3"
}

use Rack::Cors do
  allow do
    origins "http://localhost:3000"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options],
      credentials: true
  end
end

get "/" do
  "Travel Planner API"
end

get "/trips" do
 puts "========== GET /trips =========="
  puts "SESSION USER ID: #{session[:user_id]}"

  trips = Trip.where(user_id: session[:user_id])

  puts "TRIPS FOUND: #{trips.to_json}"

  trips.to_json
end

get "/users" do 
User.all.to_json
end

delete "/trips/:id" do
  trip = Trip.find(params[:id])
  trip.destroy
  { message: "Trip deleted successfully" }.to_json
end

get "/activities" do
 activities = Activity.where(user_id: session[:user_id])
 activities.to_json
end

get "/test-activity/:id" do
  activity = Activity.find(params[:id])
  activity.to_json
end

get "/trips/count" do
  Trip.trip_count.to_json
end

# delete "/activities/:id" do
  # puts "DELETE ID: #{params[:id]}"

  # activity = Activity.find(params[:id])
  # puts "FOUND ACTIVITY: #{activity.id}"

  # activity.destroy

  # { message: "Activity deleted successfully" }.to_json
# end

delete "/activities/:id" do
  activity = Activity.find(params[:id])
  activity.destroy
  { message: "Activity deleted successfully" }.to_json
end

# post "/activities" do
# data = JSON.parse(request.body.read)


get "/me" do
  if session[:user_id]
user = User.find_by(id: session[:user_id])
if user
  user.to_json
else 
  { error: "Not logged in"}.to_json
end
else
    { error: "Not logged in" }.to_json
  
end
end

post "/activities" do
  data = JSON.parse(request.body.read)
  activity = Activity.create({
    name: data["name"],
    day: data["day"],
    location: data["location"],
    time: data["time"],
    notes: data["notes"],
    trip_id: data["trip_id"],
    user_id: session[:user_id]
  })

  activity.to_json
end

patch "/activities/:id" do
  data = JSON.parse(request.body.read)
  activity = Activity.find_by(id: params[:id])
  activity.update({
     name: data["name"],
    day: data["day"],
    location: data["location"],
    time: data["time"],
    notes: data["notes"],
    trip_id: data["trip_id"]
  })
end

post "/signup" do 
  data = JSON.parse(request.body.read)
  user = User.create({
    name: data["name"],
    email: data["email"],
    password: data["password"]
  })
user.to_json

end

get "/destinations" do
  Trip.destinations.to_json
end

get "/next_trip" do
  Trip.next_trip.to_json
end

post "/login" do 
  data = JSON.parse(request.body.read)
user = User.find_by(email: data["email"])
if user && user.authenticate(data["password"])
  session[:user_id] = user.id

   puts "===================="
    puts "LOGGED IN: #{user.name}"
    puts "USER ID: #{user.id}"
    puts "SESSION ID: #{session[:user_id]}"
    puts "===================="
  {
    id: user.id,
    name: user.name,
    email: user.email
}.to_json
else 
  {
  error: "Invalid email or password"
}.to_json


end
end

delete "/logout" do
session.clear
{ message: "Logged out" }.to_json
end

post "/trips" do 
   data = JSON.parse(request.body.read)

  puts "CREATING TRIP FOR USER: #{session[:user_id]}"
  trip = Trip.create({
  name: data["name"],
  destination: data["destination"],
  start_date: data["start_date"],
  end_date: data["end_date"],
  description: data["description"],
  image_url: data["image_url"],
  user_id: session[:user_id]
})
puts "SAVED TRIP: #{trip.to_json}"

 
  trip.to_json
end
   
