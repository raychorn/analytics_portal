class FilterParam < ActiveRecord::Base
  # can belong to a report
  belongs_to :report_query
  belongs_to :dynamic_values_query, :class_name => 'Query'
  has_many :filter_param_associations, :dependent => :destroy
  has_many :filter_prefs, :through => :filter_param_associations, :dependent => :destroy

  attr_accessor :dynamic_values, :filter_param_type

  # TODO secure
  #attr_accessible

  # for single table inheritance controller
  def self.inherited(child)
    child.instance_eval do
      def model_name
        FilterParam.model_name
      end
    end
    super
  end

  # for single table inheritance controller
  def self.filter_param_subclasses
    descendants
  end

  # for single table inheritance controller
  def self.filter_param_subclasses_strings
    filter_param_subclasses.collect { |c| c.to_s }.sort
  end

  def name
    "#{type} - #{column}"
  end

  def self.search(search)
    if search
      where('column LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  #DAY_DATE = 'day_date'
  #MONTH_DATE = 'month_date'
  #CONNECTION_TYPE = 'connection_type'
  #CHECK_BOXES = 'check_boxes'
  #KPI = 'kpi'
  #
  #def options_for_filter_param_type
  #  [
  #    [DAY_DATE, 'date filter (by day)'],
  #    [MONTH_DATE, 'date picker (by month)'],
  #    [CONNECTION_TYPE, 'connection type'],
  #    [CHECK_BOXES, 'check boxes'],
  #    [KPI, 'kpi']
  #  ]
  #end

  def all_options_for_period
    [
        [604800, 'last week'],
        [2592000, 'last month'],
        [7776000, 'last 3 months'],
        [31557600, 'last year'],
        [0, 'fixed range:']
    ]
  end

  def options_for_period
    all_options_for_period.select { |opt| (opt.first >= self.min_period || opt.first == 0) }
  end

  def options_for_default_period
    all_options_for_period - [[0, 'fixed range:']]
  end

  def options_for_min_period
    all_options_for_period - [[0, 'fixed range:']]
  end

  def options_for_connection_type
    [
        [ nil, 'All Connection Types'],
        ['3GDevice', '3G'],
        ['4GDevice', '4G'],
        ['WiFiDevice', 'Wi-Fi'],
        ['EthernetDevice', 'Ethernet']
    ]
  end

  def options_for_check_boxes
    if self.enable_dynamic_values?
      self.dynamic_values
    else
      self.values.present? ? JSON.parse(self.values).collect : []
    end
  end

  def options_for_interval
    [
        ['day', 'day'],
        ['week', 'week'],
        ['month', 'month']
    ]
  end

  HIGHER_IS_BETTER = 1
  LOWER_IS_BETTER = 0

  def self.options_for_alert_direction
    [
        [HIGHER_IS_BETTER, 'Higher is better'],
        [LOWER_IS_BETTER, 'Lower is better']
    ]
  end

  # returns array of possible check box values, retrieved from a particular query result table from the admin ws
  def dynamic_values
    if @dynamic_values.blank?

      if self.column.blank?
        raise "dynamic_values column not defined for filter_param_id = #{self.id}"
      end

      query_result = self.dynamic_values_query.try(:query_result, nil, nil,
                                                   :sample_option => ::Query::Sample::REAL,
                                                   :sql_string => "SELECT `#{self.column}` FROM {table_name}"
      )
      result_set = query_result.try(:result_set)
      if !result_set.nil?
        @dynamic_values = result_set.try(:results_array).collect do |row|
          result_set.value_at(row, self.column)
        end
      end
    end

    @dynamic_values ||= []
  end

end
