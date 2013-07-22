class CreateReportQueries < ActiveRecord::Migration
  def self.up
    create_table :report_queries do |t|
      t.integer :report_id
      t.integer :query_id

      t.timestamps
    end
  end

  def self.down
    drop_table :report_queries
  end
end
