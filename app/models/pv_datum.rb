class PvDatum < ActiveRecord::Base
  #has_one :env_datum

  belongs_to :inverter

  validates :ac_power, presence: true
  validates :ac_voltage, presence: true
  validates :dc_voltage, presence: true
  validates :temperature, presence: true
  validates :total_kwh, presence: true
  validates :incident_angle, presence: true
  validates :status, presence: true

end
