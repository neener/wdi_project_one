require_relative './connection'
require_relative '../models/gallery'
require_relative './secrets'
require 'httparty'
puts API

response=HTTParty.get("http://api.nytimes.com/svc/events/v2/listings.json?&filters=category:Art,borough:Manhattan&api-key=#{API}&limit=40")["results"]

response.each do |event|

name = event["venue_name"]
gallery_event = event["event_name"]
neighborhood = event["neighborhood"]
address = event["street_address"]
opening_date = event["recurring_start_date"]
open_thru = event["recurring_end_date"]

gallery= Gallery.create :name => name, :event => gallery_event, :neighborhood => neighborhood, :address => address, :opening_date => opening_date, :open_thru => open_thru

if gallery.persisted? 
	puts "saved"
end

end

