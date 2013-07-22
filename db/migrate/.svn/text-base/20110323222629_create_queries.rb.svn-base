class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.integer :data_segment_id
      t.text :query_string
      t.boolean :store_in_db

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
