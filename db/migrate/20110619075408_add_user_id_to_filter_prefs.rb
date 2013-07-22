class AddUserIdToFilterPrefs < ActiveRecord::Migration
  def self.up
    add_column :filter_prefs, :user_id, :integer
    FilterPref.find_each do |filter_pref|
      dashboard_report = filter_pref.optionable
      if dashboard_report.instance_of?(DashboardReport)
        filter_pref.user_id = dashboard_report.dashboard.owner_id
        filter_pref.save!
      end
    end
  end

  def self.down
    remove_column :filter_prefs, :user_id
  end
end
