class EnvDatum < ActiveRecord::Base

  validates :temperature, presence: true
  validates :humidity, presence: true
  validates :insol_level, presence: true
  validates :wind_speed, presence: true
  validates :wind_direction, presence: true

end
