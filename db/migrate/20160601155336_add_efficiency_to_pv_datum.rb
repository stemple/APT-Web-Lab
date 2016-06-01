class AddEfficiencyToPvDatum < ActiveRecord::Migration
  def change
    add_column :pv_data, :efficiency, :float
  end
end
