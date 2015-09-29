class CreateEnvData < ActiveRecord::Migration
  def change
    create_table :env_data do |t|
      t.float :wind_speed
      t.integer :wind_direction
      t.float :temperature
      t.float :insol_level
      t.float :humidity

      t.timestamps null: false
    end
  end
end
