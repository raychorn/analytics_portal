class AddValuesToFilterParams < ActiveRecord::Migration
  def self.up
    add_column :filter_params, :values, :text
  end

  def self.down
    remove_column :filter_params, :values
  end
end
