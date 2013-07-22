class AddHighchartsFieldsToReportQueries < ActiveRecord::Migration
  def self.up
    add_column :report_queries, :chart_type, :string
    add_column :report_queries, :chart_params, :text
  end

  def self.down
    remove_column :report_queries, :chart_params
    remove_column :report_queries, :chart_type
  end
end
