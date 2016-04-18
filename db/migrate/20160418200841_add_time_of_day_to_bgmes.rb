class AddTimeOfDayToBgmes < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :time_of_day, :string
    add_column :bg_measurements, :bg_assessment, :string
  end
end
