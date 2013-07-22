class CreateFilterPrefs < ActiveRecord::Migration
  def self.up
    create_table :filter_prefs do |t|
      t.integer :filter_param_id
      t.integer :optionable_id
      t.string :optionable_type
      t.text :values

      t.timestamps
    end
  end

  def self.down
    drop_table :filter_prefs
  end
end
