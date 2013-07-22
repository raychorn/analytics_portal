class AddPropertiesToDataSegments < ActiveRecord::Migration
  def self.up
    add_column :data_segments, :properties, :text
  end

  def self.down
    remove_column :data_segments, :properties
  end
end
