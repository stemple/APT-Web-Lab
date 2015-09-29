class CreateInverters < ActiveRecord::Migration
  def change
    create_table :inverters do |t|
      t.float :longitude
      t.float :latitude
      t.string :serial_num
      t.string :ip_address
      t.float :elevation
      t.float :azimuth
      t.float :zenith
      t.float :time_zone

      t.timestamps null: false
    end
  end
end
