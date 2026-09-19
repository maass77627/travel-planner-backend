
class User < ActiveRecord::Base
     has_secure_password
has_many :trips
has_many :activities
validates :name, presence: true
validates :email, presence: true


def trip_count 
self.trips.length
end

def trip_names
    names = []
self.trips.each do |trip|
    names.push(trip.name)
end
return names
end


def upcoming
        upcoming_trips = []
        self.trips.each do |trip|
     if trip.start_date >= Date.today
         upcoming_trips << trip
    end
end
upcoming_trips
end





end