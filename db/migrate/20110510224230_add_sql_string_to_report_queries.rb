class AddSqlStringToReportQueries < ActiveRecord::Migration
  def self.up
    add_column :report_queries, :sql_string, :text
  end

  def self.down
    remove_column :report_queries, :sql_string
  end
end
