#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'httparty'
require 'socket'
include Socket::Constants

date = Time.new()
dc_voltage = date.min+100
ac_voltage = date.min
ac_power = date.hour*100
inv_temperature = date.day
total_kwh = date.sec
status = 1


# Calculate the incident angle using a solar position algorithm from NREL
# Usage of SPA is:
# spa <year> <month> <day> <hour> <minute> <second> <timezone> <delta_t> <longitude> <latitude> <elevation> <pressure> <temperature> <slope> <azm_rotation> <atmos_refract>
puts "Calculating the angle of incidence..."

#TODO: Must change for production
#TODO: Would be good to get the inverter values from the website first, currently they are hard coded.
spa_data = `/Users/stemple/RubymineProjects/aptweblab_old/lib/tasks/spa #{date.year} #{date.month} #{date.day} #{date.hour} #{date.min} 0 -8.0 64.797 -122.514 37.97 10 885 15 15.0 65 0.5667`

angle = spa_data.split[7].to_f

puts 'Got the angle from SPA: ' + angle.to_s

puts "Posting new inverter data to website..."

# TODO: Must change this for production!
# I use HTTParty here because it can handle nested parameters
res = HTTParty.post('http://www.aptweblab.org/pv_data', body: {pv_datum: {inverter_id: 1,
                                                                          temperature: inv_temperature,
                                                                          dc_voltage: dc_voltage,
                                                                          ac_voltage: ac_voltage,
                                                                          ac_power: ac_power,
                                                                          total_kwh: total_kwh,
                                                                          incident_angle: angle,
                                                                          status: status }}).body

puts res
puts "******************"
