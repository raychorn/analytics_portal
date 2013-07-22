class AddLayoutToDashboardReports < ActiveRecord::Migration
  def self.up
    add_column :dashboard_reports, :size, :string
    add_column :dashboard_reports, :position, :integer
  end

  def self.down
    remove_column :dashboard_reports, :position
    remove_column :dashboard_reports, :size
  end
end
