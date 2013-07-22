class CreateDashboardReports < ActiveRecord::Migration
  def self.up
    create_table :dashboard_reports do |t|
      t.integer :dashboard_id
      t.integer :report_id
      t.datetime :added_at

      t.timestamps
    end
  end

  def self.down
    drop_table :dashboard_reports
  end
end
