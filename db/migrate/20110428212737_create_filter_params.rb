class CreateFilterParams < ActiveRecord::Migration
  def self.up
    create_table :filter_params do |t|
      t.integer :report_id
      t.string :filter_param_type
      t.string :column

      t.timestamps
    end
  end

  def self.down
    drop_table :filter_params
  end
end
