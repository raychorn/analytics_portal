class CreateFilterParamAssociations < ActiveRecord::Migration
  def self.up
    create_table :filter_param_associations do |t|
      t.integer :filter_param_id
      t.integer :optionable_id
      t.string :optionable_type

      t.timestamps
    end

    remove_column :filter_params, :optionable_id
    remove_column :filter_params, :optionable_type
    add_column :filter_params, :enable_for_filter_sets, :boolean, :default => false

    remove_column :filter_prefs, :filter_param_id
    add_column :filter_prefs, :filter_param_association_id, :integer
  end

  def self.down
    remove_column :filter_prefs, :filter_param_association_id
    add_column :filter_prefs, :filter_param_id, :integer
    add_column :filter_prefs, :optionable_id, :integer
    add_column :filter_prefs, :optionable_type, :string

    remove_column :filter_params, :enable_for_filter_sets
    add_column :filter_params, :optionable_id, :integer
    add_column :filter_params, :optionable_type, :string

    drop_table :filter_param_associations
  end
end
