	require 'net/http'
	require 'json'

	city = "Bonn"
	url = URI('http://maps.googleapis.com/maps/api/geocode/json?address=' + city)
	# puts Net::HTTP.get(url)
	geodata = JSON.parse(Net::HTTP.get(url))
	geodata = geodata["results"][0]["geometry"]["location"]

	puts geodata["lat"]
	puts geodata["lng"]


