class AddPdtMeasurementTimeToBgMeasurements < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :pacific_us_mtime, :datetime
  end
end
