#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'socket'
#require 'net/ping'
include Socket::Constants
#proxy_addr = 'proxy.marinschools.org'
#proxy_port = 8080
#gardenup = "Up"
#inverterup = "Up"
#weatherup = "Up"

puts "*****************"

# first get the garden sensor station data
# puts "1. Getting the data from garden stations..."
# hostname = "10.101.5.10"
# port = 80
# request = "GET HTTP/1.0\r\n\r\n"
# if Ping.pingecho(hostname,2,port) == true
#   socket = TCPSocket.open(hostname,port)  # Connect to server
#   socket.print(request)               # Send request
#   response = socket.read              # Read complete response
#   # Split response at first blank line into headers and body
#   headers,body = response.split("\r\n\r\n", 2)
#
#   garden_records = body.split("<br><br>")
#
#   socket.close
#
#   puts "OK - got the data from the garden..."
#   puts "Posting data to the website..."
#
#   garden_records.each do |r|
#     sector = r[/sector=\w/].delete("sector=") rescue nil
#     state = r[/state=\d*/].delete("state=") rescue nil
#     humidity = r[/humidity=\d*/].delete("humidity=") rescue nil
#
#     puts sector
#     puts state
#     puts humidity
#
#     res = Net::HTTP::Proxy(proxy_addr, proxy_port).post_form(URI.parse('http://www.aptweblab.org/station_data/new'),
#       {'sector' => sector, 'state' => state, 'humidity' => humidity})
#
#     puts res
#   end
# else
#   gardenup = "Not responding to requests"
# end


# get the data from the inverter
puts "Getting the data from inverter..."
s = UDPSocket.open
hostname = "10.101.5.8"
port = 14917
s.connect(hostname,port)
s.send([].pack("x48"), 0)
m = s.recvfrom(48)

# unpack the data using a particular byte order - "Big Endian"
data = m[0].unpack("S*")
s.close

puts "OK - got the data from inverter..."

status = 0

if data[2] == 0x15
  status = 1
end

if data[2] == 0x18
  status = 2
end

dc_voltage = data[5] * 0.015441895
ac_voltage = data[8] * 0.018493652
ac_power = data[4] * 0.741699219
inv_temperature = data[7] * 0.01
total_kwh = data[16] + data[17]

puts "Data from inverter:"
puts dc_voltage
puts ac_voltage
puts ac_power
puts inv_temperature
puts total_kwh

#calculate the incident angle
# spa <year> <month> <day> <hour> <minute> <second> <timezone> <delta_t> <longitude> <latitude> <elevation> <pressure> <temperature> <slope> <azm_rotation> <atmos_refract>
puts "Calculating the angle of incidence..."
date = Time.new()
#spa_data = `/Volumes/Data/aptweblab/spa #{date.year} #{date.month} #{date.day} #{date.hour} #{date.min} 0 -8.0 64.797 -122.514 37.97 10 885 15 15.0 65 0.5667`
spa_data = `/Users/stemple/RubymineProjects/aptweblab_old/lib/tasks/spa #{date.year} #{date.month} #{date.day} #{date.hour} #{date.min} 0 -8.0 64.797 -122.514 37.97 10 885 15 15.0 65 0.5667`

angle = spa_data.split[7].to_f

puts angle.to_s

#puts "Posting new inverter data to website..."
#res = Net::HTTP.post_form(URI.parse('http://www.aptweblab.org/inverter_data/new'),
#                          {'location' => 'IA1', 'temperature' => inv_temperature, 'dc_voltage' => dc_voltage, 'ac_voltage' => ac_voltage, 'ac_power' => ac_power,
#                             'total_kwh' => total_kwh, 'angle' => angle, 'recorded_at' => date.to_s})

#puts res

# #now for the weather station
# puts "3. Getting data from weather station..."
#
# hostname = "10.101.5.9"
# port = 80
# request = "GET HTTP/1.0\r\n\r\n"
#
# if Ping.pingecho(hostname,2,port) == true
#   socket = TCPSocket.open(hostname,port)  # Connect to server
#   socket.print(request)               # Send request
#   response = socket.read              # Read complete response
#   # Split response at first blank line into headers and body
#   headers,body = response.split("\r\n\r\n", 2)
#
#   socket.close
#   puts "OK - got the data from weather station..."
#
#   temperature = body[/TEMP=\d*.\d*/].delete("TEMP=") rescue nil
#   wind_speed = body[/WS=\d*.\d*/].delete("WS=") rescue nil
#   wind_direction = body[/WD=\d*/].delete("WD=") rescue nil
#   solar_level = body[/SL=\d*.\d*/].delete("SL=") rescue nil
#   humidity = body[/HU=\d*.\d*/].delete("HU=") rescue nil
#   rain_fall = body[/RF=\d*.\d*/].delete("RF=") rescue nil
#
#   puts temperature
#   puts wind_speed
#   puts wind_direction
#   puts humidity
#   puts rain_fall
#   puts solar_level
#
#   #res = Net::HTTP.post_form(URI.parse('http://localhost:3000/inverter_data/new'),
#   res = Net::HTTP::Proxy(proxy_addr, proxy_port).post_form(URI.parse('http://www.aptweblab.org/weather_station_data/new'),
#     {'location' => 'IA1', 'temperature' => temperature, 'wind_speed' => wind_speed, 'wind_direction' => wind_direction, 'rain_fall' => rain_fall, 'humidity' => humidity, 'incident_angle' => angle, 'solar_level' => solar_level, 'recorded_at' => date.to_s })
#
#   puts res
# else
#   weatherup = "Not responding to requests"
# end
#
puts Time.new()
puts "******************"
# puts "The garden station is: "
# puts gardenup
#puts "The inverter is: "
#puts inverterup
# puts "The weather station is: "
# puts weatherup
# puts "All data for stations that  are Up was posted! SUCCESS!"
