class GraphsController < ApplicationController
  def index
    start_date = Time.new.beginning_of_month
    end_date = Time.new.utc.tomorrow
    #:order => "created_at", :conditions => [
    day_data = PvDatum.where('created_at >= ? and created_at <= ?', start_date.beginning_of_month, end_date.end_of_month).group_by { |data| data.created_at.at_beginning_of_day }
    kwh_days = Array.new
    kwh_data = Array.new
    day_data.keys.each do |day|
      kwh_data.push(day_data.fetch(day).last.total_kwh - day_data.fetch(day).first.total_kwh)
      kwh_days.push(day.strftime("%d"))
    end

    # combine the arrays
    @graph_data = kwh_days.zip(kwh_data)

  end

  def show_ac_for_day
    start_date = Time.new.beginning_of_day
    end_date = Time.new
    ac_data = PvDatum.where('created_at >= ? and created_at <= ?', start_date, end_date)




  end
end
