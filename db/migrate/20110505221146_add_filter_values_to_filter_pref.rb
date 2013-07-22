class AddFilterValuesToFilterPref < ActiveRecord::Migration
  def self.up
    add_column :filter_prefs, :start_date, :datetime
    add_column :filter_prefs, :end_date, :datetime
    add_column :filter_prefs, :period, :integer
    add_column :filter_prefs, :selected, :string
  end

  def self.down
    remove_column :filter_prefs, :selected
    remove_column :filter_prefs, :period
    remove_column :filter_prefs, :end_date
    remove_column :filter_prefs, :start_date
  end
end
