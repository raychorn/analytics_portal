class AddScheduleToDataSegments < ActiveRecord::Migration
  def self.up
    add_column :data_segments, :schedule, :string
    add_column :data_segments, :enable_schedule, :boolean, :default => false
  end

  def self.down
    remove_column :data_segments, :enable_schedule
    remove_column :data_segments, :schedule
  end
end
