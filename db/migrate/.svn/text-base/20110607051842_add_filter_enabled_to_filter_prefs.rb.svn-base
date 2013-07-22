class AddFilterEnabledToFilterPrefs < ActiveRecord::Migration
  def self.up
    add_column :filter_prefs, :filter_enabled, :boolean
  end

  def self.down
    remove_column :filter_prefs, :filter_enabled
  end
end
