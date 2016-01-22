class CreateEnergyData < ActiveRecord::Migration
  def change
    create_table :energy_data do |t|
      t.integer :day
      t.integer :month
      t.integer :year
      t.float :kwh

      t.timestamps null: false
    end
  end
end
