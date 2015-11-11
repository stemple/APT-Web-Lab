#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'httparty'

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

res = HTTParty.post('http://localhost:3000/pv_data', body: {pv_datum: {inverter_id: 2,
                                                                    temperature: inv_temperature,
                                                                    dc_voltage: dc_voltage,
                                                                    ac_voltage: ac_voltage,
                                                                    ac_power: ac_power,
                                                                    total_kwh: total_kwh,
                                                                    incident_angle: angle,
                                                                    status: 2 }}).body


#uri = URI('http://www.aptweblab.org/pv_data')
#req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
#req.body = {:pv_datum =>{:inverter_id => 2,
#                         :temperature => inv_temperature,
#                         :dc_voltage => dc_voltage,
#                         :ac_voltage => ac_voltage,
#                         :ac_power => ac_power,
##                        :total_kwh => total_kwh,
#                         :incident_angle => angle,
#                         :status => 1}}.to_json
#res = Net::HTTP.start(uri.hostname, uri.port) do |http|
#  http.request(req)
#end

puts res

#uri = URI.parse('http://localhost:3000/pv_data')
#req = Net::HTTP::Post.new uri.path
#req.body = {:pv_datum =>{:inverter_id => 2,
#          :temperature => inv_temperature,
#          :dc_voltage => dc_voltage,
#          :ac_voltage => ac_voltage,
#          :ac_power => ac_power,
#          :total_kwh => total_kwh,
#          :incident_angle => angle,
#          :status => 1}}

#res = Net::HTTP.start(uri.host, uri.port, :use_ssl => false) do |http|
#  http.request req
#end

#puts res.body

#response = Net::HTTP.post_form(uri, :pv_datum =>{:inverter_id => 2,
#                                      :temperature => inv_temperature,
#                                      :dc_voltage => dc_voltage,
#                                      :ac_voltage => ac_voltage,
#                                      :ac_power => ac_power,
#                                      :total_kwh => total_kwh,
#                                      :incident_angle => angle,
#                                      :status => 1})

# Full control
#http = Net::HTTP.new(uri.host, uri.port)

#request = Net::HTTP::Post.new(uri.request_uri)
#request.set_form_data({"q" => "My query", "per_page" => "50"})

#response = http.request(request)





#req = Net::HTTP::Post.new(uri)
#req.set_form_data('inverter_id' => '2',
#                  'temperature' => inv_temperature,
#                  'dc_voltage' => dc_voltage,
#                  'ac_voltage' => ac_voltage,
#                 'ac_power' => ac_power,
#                  'total_kwh' => total_kwh,
#                  'incident_angle' => angle,
#                  'status' => '1')

#response = Net::HTTP.start(uri.hostname, uri.port) do |http|
#  http.request(req)
#end

#res = Net::HTTP.post_form URI('http://www.aptweblab.org/pv_data/new'),
#                          {'inverter_id' => '2',
#                           'temperature' => inv_temperature,
#                           'dc_voltage' => dc_voltage,
#                           'ac_voltage' => ac_voltage,
#                           'ac_power' => ac_power,
#                           'total_kwh' => total_kwh,
#                           'incident_angle' => angle,
#                           'status' => '1'}

#puts res