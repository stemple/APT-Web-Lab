class PvDataController < ApplicationController
  def index
    @pv_data = PvDatum.all
  end

  def show
    @pv_datum = PvDatum.find(params[:id])
  end

  def new
    @pv_datum = PvDatum.new
  end

  def create
    #TODO: Must fix this!
    #@temp = params[:pv_datum]
    #puts "++++++++"
    #puts pv_datum_params
    #puts "++++++++"
    @inverter = Inverter.find_by(id: pv_datum_params[:inverter_id])
    @pv_datum = @inverter.pv_data.create(pv_datum_params)
    redirect_to pv_datum_path(@pv_datum)
  end


  private

  def pv_datum_params
    params.require(:pv_datum).permit(:ac_power, :dc_voltage, :ac_voltage, :total_kwh, :incident_angle,
                                     :temperature, :status, :inverter_id)
  end
end
