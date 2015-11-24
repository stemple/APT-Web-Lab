class InvertersController < ApplicationController

  http_basic_authenticate_with name: 'apt_admin', password: 'secret', except: [:index, :show]

  def index
    @inverters = Inverter.all
  end

  def show
    @inverter = Inverter.find(params[:id])
  end

  def new
    @inverter = Inverter.new
  end

  def edit
    @inverter = Inverter.find(params[:id])
  end

  def create
    @inverter = Inverter.new(inverter_params)

    if @inverter.save
      redirect_to @inverter
    else
      render 'new'
    end
  end

  def update
    @inverter = Inverter.find(params[:id])

    if @inverter.update(inverter_params)
      redirect_to @inverter
    else
      render 'edit'
    end
  end

  def destroy
    @inverter = Inverter.find(params[:id])
    @inverter.destroy

    redirect_to inverters_path
  end

  private
  def inverter_params
    params.require(:inverter).permit(:longitude, :latitude, :serial_num, :ip_address, :elevation, :azimuth,
                                     :zenith, :time_zone)
  end
end