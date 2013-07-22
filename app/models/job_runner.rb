class JobRunner < ActiveResource::Base
  self.site = "http://analytics-admin:3001/"

  def start
    self.get(:start)
  end

  def enable_schedule
    self.get(:enable_schedule)
  end

  def disable_schedule
    self.get(:disable_schedule)
  end
end