#!/usr/bin/env ruby

# Get the previous day's values.
start_day = Time.zone.now - (60*60*24)
start_day = start_day.beginning_of_day
end_day = start_day + (60*60*24)
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


