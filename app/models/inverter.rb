class Inverter < ActiveRecord::Base
  validates :ip_address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :serial_num, presence: true
  validates :elevation, presence: true
  validates :azimuth, presence: true
  validates :zenith, presence: true
  validates :time_zone, presence:true
end
