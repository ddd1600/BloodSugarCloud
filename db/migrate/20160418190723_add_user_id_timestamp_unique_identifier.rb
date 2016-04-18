class AddUserIdTimestampUniqueIdentifier < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :user_email_bg_timestamp, :string
    add_index :bg_measurements, :user_email_bg_timestamp
  end
end
