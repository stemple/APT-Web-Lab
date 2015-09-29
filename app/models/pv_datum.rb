class PvDatum < ActiveRecord::Base
  belongs_to :env_datum
  belongs_to :inverter
end
