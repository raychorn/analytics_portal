class DataSegmentJobRunner < ActiveRecord::Base
  belongs_to :data_segment
  attr_accessor :job_runner

  def job_runner
    @job_runner ||= JobRunner.find(self.job_runner_id)
    self.job_runner_id = @job_runner.try(:id)
    @job_runner
  end

  def job_runner=(job_runner)
    @job_runner = job_runner
    self.job_runner_id = @job_runner.try(:id)
    @job_runner
  end
end