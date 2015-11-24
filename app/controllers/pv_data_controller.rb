class PvDataController < ApplicationController
  protect_from_forgery :except => [:create]
  http_basic_authenticate_with name: 'apt_admin', password: 'secret', except: [:index, :show, :create, :new]

  def index
    @pv_data = PvDatum.all
  end

  def show
    @pv_datum = PvDatum.find(params[:id])
  end

  def new
    @pv_datum = PvDatum.new
  end

  def edit
    @pv_datum = PvDatum.find(params[:id])
  end

  def create
    @inverter = Inverter.find_by(id: pv_datum_params[:inverter_id])
    @pv_datum = @inverter.pv_data.create(pv_datum_params)
    redirect_to pv_datum_path(@pv_datum)
  end

  def destroy
    @pv_datum = PvDatum.find(params[:id])
    @pv_datum.destroy

    redirect_to pv_data_path
  end


  private

  def pv_datum_params
    params.require(:pv_datum).permit(:ac_power, :dc_voltage, :ac_voltage, :total_kwh, :incident_angle,
                                     :temperature, :status, :inverter_id)
  end
end
