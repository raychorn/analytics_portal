class CreateDataSegmentJobRunners < ActiveRecord::Migration
  def self.up
    create_table :data_segment_job_runners do |t|
      t.integer :data_segment_id
      t.integer :job_runner_id
    end
  end

  def self.down
    drop_table :data_segment_job_runners
  end
end
