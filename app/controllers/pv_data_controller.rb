class PvDataController < ApplicationController
  def new

  end

  def create
    @PvDatum = PvDatum.new(params[:pv_datum])

    @PvDatum.save
    redirect_to @PvDatum
  end
end
