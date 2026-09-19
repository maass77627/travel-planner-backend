

class Trip < ActiveRecord::Base
    belongs_to :user
    has_many :activities

    def upcoming?
       start_date >= Date.today
    end

def past 
past_trips = []
Trip.all.each do |trip|
if trip.end_date < Date.today
    past_trips.push(trip)
end
end
past_trips
end

def trip_count
Trip.all.length

end


def destinations
destinations = []

  Trip.all.each do |trip|
    destinations.push(trip.destination)
  end

  destinations
end

def find_trip(name)
Trip.all.find do |trip|
    trip.name == name
end
end

def next_trip
upcoming_trips = Trip.all.select do |trip|
    trip.upcoming?
end
upcoming_trips.sort_by {|trip| trip.start_date}.first
end




end