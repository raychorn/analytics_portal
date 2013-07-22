class CreateReportLinks < ActiveRecord::Migration
  def self.up
    create_table :report_links do |t|
      t.string :name
      t.integer :report_id
      t.integer :linked_report_id
      t.string :filter_columns

      t.timestamps
    end
  end

  def self.down
    drop_table :report_links
  end
end
