class AddDatabaseNameToDataSources < ActiveRecord::Migration
  def self.up
    add_column :data_sources, :database_name, :string
  end

  def self.down
    remove_column :data_sources, :database_name
  end
end
