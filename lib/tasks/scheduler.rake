desc "This task is called by the Heroku scheduler add-on"
task :archive_kwh => :environment do

  require 'rubygems'
  require 'oauth'
  require 'json'

  puts "Updating kwh..."
  # Get the previous day's values.
  start_day = Time.zone.now - (60*60*24)
  start_day = start_day.beginning_of_day
  end_day = start_day + (60*60*24)
  day_data = PvDatum.where('created_at <= ?', end_day).order(created_at: :desc).group_by { |data| data.created_at.at_beginning_of_day }
  # VERY IMPORTANT: The inverter is malfunctioning and is counting down!
  #TODO: Must fix inverter!
  kwh = 0
  day_data.keys.each do |day|

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

  consumer_key = OAuth::Consumer.new(
      "mGBhrh5xQstOd9ooaN4hD5gjQ",
      "JxLXRbnpyMPQGfhdkEMP7gU9WpeGTxDjmxRJgmTBjll5EDw6u4")
  access_token = OAuth::Token.new(
      "259889259-pylA3EWZwz9VrexU50bg3bBpRqwzFxbtFWuXujj6",
      "VVWqoWw1GdIiQ7b5t4tkiIyTQxcqFJGDc7eVGlrcTVjaP")

  # Note that the type of request has changed to POST.
  # The request parameters have also moved to the body
  # of the request instead of being put in the URL.
  baseurl = "https://api.twitter.com"
  path    = "/1.1/statuses/update.json"
  address = URI("#{baseurl}#{path}")
  request = Net::HTTP::Post.new address.request_uri
  request.set_form_data(
      "status" => "Total Daily Power: #{kwh} /n",
  )

  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
end