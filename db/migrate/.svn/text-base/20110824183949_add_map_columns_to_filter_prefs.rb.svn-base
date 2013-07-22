class AddMapColumnsToFilterPrefs < ActiveRecord::Migration
  def self.up
    add_column :filter_prefs, :lat, :float, :default => 0.0
    add_column :filter_prefs, :lng, :float, :default => 0.0
    add_column :filter_prefs, :zoom, :integer, :default => 0
  end

  def self.down
    remove_column :filter_prefs, :zoom
    remove_column :filter_prefs, :lng
    remove_column :filter_prefs, :lat
  end
end
