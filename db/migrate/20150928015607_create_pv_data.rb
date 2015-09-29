class CreatePvData < ActiveRecord::Migration
  def change
    create_table :pv_data do |t|
      t.float :dc_voltage
      t.float :ac_voltage
      t.float :ac_power
      t.integer :status
      t.float :temperature
      t.float :total_kwh
      t.float :incident_angle
      t.references :env_datum, index: true, foreign_key: true
      t.references :inverter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
