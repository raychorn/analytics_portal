class AddDataSymbolsToReportQueries < ActiveRecord::Migration
  def self.up
    add_column :report_queries, :x_column, :string
    add_column :report_queries, :y_column, :string
    add_column :report_queries, :radius_column, :string
    add_column :report_queries, :name_column, :string
  end

  def self.down
    remove_column :report_queries, :name_column
    remove_column :report_queries, :radius_column
    remove_column :report_queries, :y_column
    remove_column :report_queries, :x_column
  end
end
