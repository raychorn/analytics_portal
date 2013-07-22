class CreateFilterSets < ActiveRecord::Migration
  def self.up
    create_table :filter_sets do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    rename_column :filter_params, :report_id, :optionable_id
    add_column :filter_params, :optionable_type, :string
    add_column :dashboards, :filter_set_id, :integer
    add_column :reports, :filter_set_id, :integer
  end

  def self.down
    remove_column :reports, :filter_set_id
    remove_column :dashboards, :filter_set_id
    remove_column :filter_params, :optionable_type
    rename_column :filter_params, :optionable_id, :report_id
    drop_table :filter_sets
  end
end
