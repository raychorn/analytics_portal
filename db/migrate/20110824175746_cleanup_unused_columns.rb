class CleanupUnusedColumns < ActiveRecord::Migration
  def self.up
    remove_column :dashboards, :filter_prefs
  end

  def self.down
    add_column :dashboards, :filter_prefs, :text
  end
end
