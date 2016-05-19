class AddEstMeasurementTimeToBgmeasurements < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :eastern_us_mtime, :datetime
    add_column :bg_measurements, :unix_epoch_mtime, :integer
  end
end
