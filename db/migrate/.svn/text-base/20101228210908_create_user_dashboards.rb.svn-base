class CreateUserDashboards < ActiveRecord::Migration
  def self.up
    create_table :user_dashboards do |t|
      t.integer :user_id
      t.integer :dashboard_id
      t.string :created_by
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_dashboards
  end
end
