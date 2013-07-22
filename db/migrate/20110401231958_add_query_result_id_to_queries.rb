class AddQueryResultIdToQueries < ActiveRecord::Migration
  def self.up
    add_column :queries, :query_result_id, :integer
  end

  def self.down
    remove_column :queries, :query_result_id
  end
end
