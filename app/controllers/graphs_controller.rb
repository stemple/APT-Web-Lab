class GraphsController < ApplicationController
  def index
    @pv_ac_graph_data = get_pv_ac_data
    @kwh_graph_data = get_kwh_data
  end

  def show_ac_for_day

  end

  private

  def get_pv_ac_data
    start_date = Time.zone.now.beginning_of_day
    end_date = Time.zone.now
    data = PvDatum.where('created_at >= ? and created_at <= ?', start_date, end_date)
    ac_data = Array.new
    times = Array.new
    data.each do |datum|
      ac_data.push(datum.ac_power)
      #TODO: Need to fix this timezone formatting issue for Highcharts
      times.push(datum.created_at.utc - 8.hours)
    end

    # combine the arrays
    times.zip(ac_data)
  end

  def get_kwh_data
    start_date = Time.zone.now.beginning_of_month
    end_date = Time.zone.now.tomorrow
    day_data = EnergyDatum.where('created_at >= ? and created_at <= ?', start_date, end_date)
    kwh_days = Array.new
    kwh_data = Array.new
    day_data.each do |day|
      kwh_data.push(day.kwh)
      #TODO: Need to fix this date formatting issue for Highcharts
      kwh_days.push(day.day)
    end

    # combine the arrays
    kwh_days.zip(kwh_data)
  end

end
