#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'socket'
include Socket::Constants

dc_voltage = 300
ac_voltage = 240
ac_power = 100
inv_temperature = 70
total_kwh = 1200


#calculate the incident angle
# spa <year> <month> <day> <hour> <minute> <second> <timezone> <delta_t> <longitude> <latitude> <elevation> <pressure> <temperature> <slope> <azm_rotation> <atmos_refract>
date = Time.new()
#spa_data = `/Volumes/Data/aptweblab/spa #{date.year} #{date.month} #{date.day} #{date.hour} #{date.min} 0 -8.0 64.797 -122.514 37.97 10 885 15 15.0 65 0.5667`
spa_data = `/Users/stemple/RubymineProjects/aptweblab_old/lib/tasks/spa #{date.year} #{date.month} #{date.day} #{date.hour} #{date.min} 0 -8.0 64.797 -122.514 37.97 10 885 15 15.0 65 0.5667`

angle = spa_data.split[7].to_f

puts angle.to_s


res = Net::HTTP.post_form(URI.parse('http://localhost:3000/pv_data/new'),
                          {'inverter_id' => '2',
                           'temperature' => inv_temperature,
                           'dc_voltage' => dc_voltage,
                           'ac_voltage' => ac_voltage,
                           'ac_power' => ac_power,
                           'total_kwh' => total_kwh,
                           'incident_angle' => angle,
                           'status' => '1'})

puts res