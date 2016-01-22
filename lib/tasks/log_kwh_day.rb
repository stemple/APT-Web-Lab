#!/usr/bin/env ruby
puts ARGV[0]
puts ARGV[1]
puts ARGV[2]

# Get the previous day's values.
start_day = Time.zone.new(ARGV[0], ARGV[1], ARGV[2], 0, 0, 0, '-08:00')
end_day = start_day - (60*60*24)
day_data = PvDatum.where('created_at >= ? and created_at <= ?', start_day, end_day)
# VERY IMPORTANT: The inverter is malfunctioning and is counting down!
#TODO: Must fix inverter!
kwh = 0
if day_data.length === 0
  kwh = 0
else
    kwh = day_data.first.total_kwh - day_data.last.total_kwh
end

#Create new record for day's kwh
ed = EnergyDatum.new do |e|
  e.kwh = kwh
  e.day = start_day.day
  e.month = start_day.month
  e.year = start_day.year
end

ed.save

#Delete the previous day's data
day_data.delete_all()


