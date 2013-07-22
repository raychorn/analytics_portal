class AddKpiToFilterPrefs < ActiveRecord::Migration
  def self.up
    add_column :filter_prefs, :enable_email, :boolean
    add_column :filter_prefs, :alert_direction, :integer
    add_column :filter_prefs, :name, :string
    add_column :filter_prefs, :target, :string
  end

  def self.down
    remove_column :filter_prefs, :name
    remove_column :filter_prefs, :alert_direction
    remove_column :filter_prefs, :enable_email
    remove_column :filter_prefs, :target
  end
end
