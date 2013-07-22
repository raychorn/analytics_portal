class AddDynamicValuesToFilterParams < ActiveRecord::Migration
  def self.up
    add_column :filter_params, :enable_dynamic_values, :boolean, :default => false
    add_column :filter_params, :dynamic_values_query_id, :integer
  end

  def self.down
    remove_column :filter_params, :dynamic_values_query_id
    remove_column :filter_params, :enable_dynamic_values
  end
end
