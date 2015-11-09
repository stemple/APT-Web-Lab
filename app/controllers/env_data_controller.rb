class EnvDataController < ApplicationController
  def index
    @env_data = EnvDatum.all
  end

  def show
    @env_datum = EnvDatum.find(params[:id])
  end

  def new
    @env_datum = EnvDatum.new
  end

  def edit
    @env_datum = EnvDatum.find(params[:id])
  end

  def create
    @env_datum = EnvDatum.new(env_datum_params)

    @env_datum.save
    redirect_to @env_datum
  end

  def update
    @env_datum = EnvDatum.find(params[:id])

    if @env_datum.update(env_datum_params)
      redirect_to @env_datum
    else
      render 'edit'
    end
  end

  def destroy
    @env_datum = EnvDatum.find(params[:id])
    @env_datum.destroy

    redirect_to env_data_path
  end

  private
  def env_datum_params
    params.require(:env_datum).permit(:temperature, :humidity, :wind_speed, :wind_direction, :insol_level)
  end
end
