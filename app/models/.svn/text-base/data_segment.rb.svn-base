class DataSegment < ActiveRecord::Base
  has_many :data_segment_job_runners
  has_many :queries, :dependent => :destroy
  belongs_to :data_source

  validates_presence_of :name, :data_source_id
  validates_uniqueness_of :name
  validates :properties, :json_or_blank => true

  accepts_nested_attributes_for :queries, :allow_destroy => true, :reject_if => lambda { |a| a[:query_string].blank? }

  def job_runners
    @job_runner ||= self.data_segment_job_runners.collect { |d| d.job_runner }
  end

  # TODO implement
  def last_updated
    nil
  end

  # TODO implement
  def next_scheduled
    schedule
  end

  def job_runners_status
    begin
      self.job_runners.collect { |j|
        status = j.status
        "#{status.respond_to?(:message) ? j.status.message : j.status.status}"
      }.join "\n"
    rescue ActiveResource::ServerError, Errno::ECONNREFUSED
      "The data source appears to be down.  Contact your administrator."
    rescue NoMethodError => e
      "#{e.class}: #{e.message}"
    rescue Exception => e
      # TODO log error
      "An unexpected error occurred with the data source.  Contact your administrator.  #{e.class}: #{e.message}"
    end
  end

  def data_source_name
    self.data_source.try(:name)
  end

  def properties_hash
    self.properties.present? ? JSON.parse(self.properties) : {}
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def setup_job_runners
    # create data_segment_job_runner and job_runner if they don't already exist
    if self.data_segment_job_runners.blank?
      self.data_segment_job_runners.build
      job_runner = JobRunner.build
      job_runner.database_name = self.data_source.database_name
      job_runner.schedule = self.schedule
      job_runner.save!
      self.data_segment_job_runners.first.job_runner = job_runner
      self.save!
    elsif self.data_segment_job_runners.first.job_runner.blank?
      job_runner = JobRunner.build
      job_runner.database_name = self.data_source.database_name
      job_runner.schedule = self.schedule
      job_runner.save!
      self.data_segment_job_runners.first.job_runner = job_runner
      self.save!
    end

    self.job_runners.each do |jr|
      jr.queries = self.queries.collect do |query|
        begin
          qr = QueryResult.find(query.query_result_id) # nil ID also throws same exception
        rescue ActiveResource::ResourceNotFound
          qr = QueryResult.new
        end
        qr.database_name = self.data_source.database_name
        qr.query_string = query.token_replaced_hive_query_string
        qr.store_in_db = query.store_in_db
        qr.save!
        query.query_result_id = qr.id
        qr.query_result_id = qr.id
        query.save!

        qr # collect
      end
      jr.database_name = self.data_source.database_name
      jr.schedule = self.schedule
      jr.query_results = nil
      jr.status = nil
      jr.save!
    end
  end

  def send_enable_schedule
    self.job_runners.each do |jr|
      jr.enable_schedule
    end
  end

  def send_disable_schedule
    self.job_runners.each do |jr|
      jr.disable_schedule
    end
  end

  def start_job_runners
    setup_job_runners
    self.job_runners.each do |jr|
      jr.start
    end
  end

end
