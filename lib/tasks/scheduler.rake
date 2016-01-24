desc "This task is called by the Heroku scheduler add-on"
task :archive_kwh => :environment do
  puts "Updating kwh..."
  # Get the previous day's values.
  start_day = Time.zone.now - (60*60*24)
  start_day = start_day.beginning_of_day
  end_day = start_day + (60*60*24)
  day_data = PvDatum.where('created_at <= ?', end_day).group_by { |data| data.created_at.at_beginning_of_day }
  # VERY IMPORTANT: The inverter is malfunctioning and is counting down!
  #TODO: Must fix inverter!
  day_data.keys.each do |day|

    kwh = 0
    if day_data.length === 0
      kwh = 0
    else
      kwh = (day_data.fetch(day).last.total_kwh - day_data.fetch(day).first.total_kwh).abs
    end

    #Create new record for day's kwh
    ed = EnergyDatum.new do |e|
      e.kwh = kwh
      e.day = day.day
      e.month = day.month
      e.year = day.year
    end

    ed.save
  end


  #Delete the previous day's data
  day_data = PvDatum.where('created_at <= ?', end_day)
  day_data.delete_all()
  puts "Done."
end