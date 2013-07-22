class AddFilterPrefsToDashboards < ActiveRecord::Migration
  def self.up
    add_column :dashboards, :filter_prefs, :text
  end

  def self.down
    remove_column :dashboards, :filter_prefs
  end
end
