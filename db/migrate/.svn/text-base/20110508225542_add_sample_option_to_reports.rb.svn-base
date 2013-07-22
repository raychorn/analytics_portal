class AddSampleOptionToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :sample_option, :integer, :default => 0
  end

  def self.down
    remove_column :reports, :sample_option
  end
end
