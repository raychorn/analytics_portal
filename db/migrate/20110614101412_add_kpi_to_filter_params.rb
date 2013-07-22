class AddKpiToFilterParams < ActiveRecord::Migration
  def self.up
    add_column :filter_params, :date_column, :string
    add_column :filter_params, :default_name, :string
    add_column :filter_params, :report_query_id, :integer
    add_column :filter_params, :interval, :string
  end

  def self.down
    remove_column :filter_params, :interval
    remove_column :filter_params, :report_query_id
    remove_column :filter_params, :default_name
    remove_column :filter_params, :date_column
  end
end
