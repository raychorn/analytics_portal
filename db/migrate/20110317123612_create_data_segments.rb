class CreateDataSegments < ActiveRecord::Migration
  def self.up
    create_table :data_segments do |t|
      t.string :name
      t.string :description
      t.integer :data_source_id

      t.timestamps
    end
  end

  def self.down
    drop_table :data_segments
  end
end
