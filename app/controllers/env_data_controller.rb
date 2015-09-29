class EnvDataController < ApplicationController
  def index
    @env_data = EnvDatum.all
  end

  def show
    @env_datum = EnvDatum.find(params[:id])
  end

  def new
  end

  def create
    @env_datum = EnvDatum.new(env_datum_params)

    @env_datum.save
    redirect_to @env_datum
  end

  private
  def env_datum_params
    params.require(:env_datum).permit(:temperature, :humidity, :wind_speed, :wind_direction, :insol_level)
  end
end
