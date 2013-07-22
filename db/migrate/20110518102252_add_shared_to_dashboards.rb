class AddSharedToDashboards < ActiveRecord::Migration
  def self.up
    add_column :dashboards, :shared, :boolean, :default => false
  end

  def self.down
    remove_column :dashboards, :shared
  end
end
