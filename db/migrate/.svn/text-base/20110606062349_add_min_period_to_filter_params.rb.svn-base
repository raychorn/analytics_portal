class AddMinPeriodToFilterParams < ActiveRecord::Migration
  def self.up
    add_column :filter_params, :min_period, :integer, :default => 604800
  end

  def self.down
    remove_column :filter_params, :min_period
  end
end
