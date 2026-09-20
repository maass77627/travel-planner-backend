

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

def self.trip_count
Trip.all.length

end

def self.next_trip 
trip = Trip.order(:start_date).first
trip.to_json
end



def self.destinations
  Trip.all.map do |trip|
    trip.destination
  end
end

def find_trip(name)
Trip.all.find do |trip|
    trip.name == name
end
end






end