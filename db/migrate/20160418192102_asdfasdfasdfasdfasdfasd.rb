class Asdfasdfasdfasdfasdfasd < ActiveRecord::Migration
  def change
    remove_column :bg_measurements, :patient_id
    add_column :bg_measurements, :measurement_time, :datetime
    add_column :users, :time_zone, :string
  end
end
