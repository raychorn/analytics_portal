class Query < ActiveRecord::Base
  belongs_to :data_segment
  has_many :report_queries, :dependent => :destroy

  validates_presence_of :query_string
  validates :sample_data, :json_or_blank => true

  attr_reader :query_result

  scope :stored_in_db, order('name ASC').where(:store_in_db => true)

  # option for where to get data from: use real data, load from the portal, or load from the web service
  class Sample
    REAL = 0 # default
    REAL_JSON = 1
    PORTAL = 2
    REMOTE = 3
    PORTAL_JSON = 4
    REMOTE_JSON = 5

    def self.all
      ALL
    end

    def self.options
      OPTIONS
    end

    def self.result_is_json?(sample_option)
      case sample_option
        when Sample::REAL_JSON
          true
        when Sample::PORTAL_JSON
          true
        when Sample::REMOTE_JSON
          true
        else
          false
      end
    end

    private #################

    ALL = [REAL, REAL_JSON, PORTAL, REMOTE, PORTAL_JSON, REMOTE_JSON]

    OPTIONS = [
        [REAL, 'real data'],
        [REAL_JSON, 'real json data'],
        [PORTAL, 'portal sample'],
        [REMOTE, 'remote sample'],
        [PORTAL_JSON, 'portal JSON sample'],
        [REMOTE_JSON, 'remote JSON sample']
    ]
  end

  # from http://codeidol.com/other/rubyckbk/Strings/Replacing-Multiple-Patterns-in-a-Single-Pass/
  def self.mgsub(str, key_value_pairs=[].freeze)
    regexp_fragments = key_value_pairs.collect { |k, v| k }
    str.gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect { |k, v| k =~ match }[1]
    end
  end

  def data_segment_name
    data_segment = self.data_segment
    data_segment.present? ? "(#{data_segment.id}) #{data_segment.name}" : ''
  end

  # takes an optional sample_option
  def query_result(filter_prefs = {}, filter_set = nil, options = {})
    options ||= {} # in case options is nil
    sample_option = options[:sample_option]
    sql_string = options[:sql_string]

    case sample_option
      when self.class::Sample::PORTAL
        raise 'tabular sample data from portal not implemented'
      when self.class::Sample::REMOTE_JSON
        raise 'JSON sample data from remote web service not implemented'
      when self.class::Sample::REMOTE
        @query_result ||= QueryResult.find(self.id, :params =>
            {
                :sql_string => token_replaced_sql_string(sql_string, filter_prefs, filter_set),
                :sample_option => sample_option
            }
        )
      when self.class::Sample::PORTAL_JSON
        @query_result = QueryResult.new(
            :result_set => ResultSet.new(
                :result_type => 'json',
                :latest_data_results =>
                    (self.sample_data.present? ? [self.sample_data] : [])
            )
        )
      else # nil or Query::Sample::REAL
      if self.query_result_id.nil?
        @query_result = nil
      else
        @query_result ||= QueryResult.find(self.query_result_id, :params =>
            {
                :query_string => self.token_replaced_hive_query_string,
                :sql_string => token_replaced_sql_string(sql_string, filter_prefs, filter_set)
            }
        )
      end
    end
    @query_result
  end

  def token_replaced_hive_query_string
#    date_query = ''
#    properties_hash = self.data_segment.properties_hash
#    start_date_month = properties_hash['start_date_month']
#    if start_date_month.present?
#      date_query << " AND concat(year,\"-\",month)>='#{start_date_month}'"
#    end
#    end_date_month = properties_hash['end_date_month']
#    if end_date_month.present?
#      date_query << " AND concat(year,\"-\",month)<='#{end_date_month}'"
#    end

#    self.query_string.gsub(/\{and_date_range_by_month\}/, date_query).
#        gsub(/\{1_month_ago\}/, 1.month.ago.strftime('%Y-%m')).
#        gsub(/\{2_months_ago\}/, 2.month.ago.strftime('%Y-%m'))

    query_string = self.query_string

    # WHERE concat(year,"-",month) = '#current_month'
    if !query_string.index(/\{where_1_month_ago\}/).nil?
      where_1_month_ago = "WHERE concat(year,\"-\",month) = '#{1.month.ago.strftime('%Y-%m')}'"
    else
      where_1_month_ago = ''
    end

    # WHERE concat(year,"-",month) = '#current_month'
    if !query_string.index(/\{where_before_1_month_ago\}/).nil?
      where_before_1_month_ago = "WHERE concat(year,\"-\",month) < '#{1.month.ago.strftime('%Y-%m')}'"
    else
      where_before_1_month_ago = ''
    end

    # WHERE concat(year,"-",month) = '#previous_month'
    if !query_string.index(/\{where_2_month_ago\}/).nil?
      where_2_months_ago = "WHERE concat(year,\"-\",month) = '#{2.month.ago.strftime('%Y-%m')}'"
    else
      where_2_months_ago = ''
    end

    # AND manufacturer = '#c_36'
    if !query_string.index(/\{and_manufacturer\}/).nil?
      and_manufacturer = ''
    end

    # AND device_model = '#c_37'
    if !query_string.index(/\{and_device_model\}/).nil?
      and_device_model = ''
    end

    substitutions = [
      [/\{where_1_month_ago\}/, where_1_month_ago],
      [/\{where_before_1_month_ago\}/, where_before_1_month_ago],
      [/\{where_2_months_ago\}/, where_2_months_ago],
      [/\{and_manufacturer\}/, and_manufacturer],
      [/\{and_device_model\}/, and_device_model]
    ]

    self.class.mgsub(query_string, substitutions)
  end

  def self.search(search)
    if search
      where('query_string LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def token_replaced_sql_string(sql_string, filter_prefs, filter_set = nil)

    query_array = []
    all_filter_prefs = (filter_prefs || []) + (filter_set.try(:filter_prefs) || [])

    if all_filter_prefs.present?
      all_filter_prefs.each do |fp|
        filter_param_type = fp.filter_param.try(:filter_param_type)

        ########## date ####################
        if filter_param_type == FilterParam::DAY_DATE || filter_param_type == FilterParam::MONTH_DATE

          case filter_param_type
            when FilterParam::MONTH_DATE
              date_format = '%Y-%m'
            when FilterParam::DAY_DATE
              date_format = '%Y-%m-%d'
          end

          date_column = fp.filter_param.column
          if fp.period_selected?
            if fp.period.nil?
              period = fp.filter_param.default_period
            else
              period = fp.period
            end
            start_date = (period.nil? ? nil : period.ago.strftime(date_format))
            end_date = nil
          else
            start_date = fp.start_date.strftime(date_format)
            end_date = fp.end_date.strftime(date_format)
          end
          query_array << "#{date_column} >= '#{start_date}'" if start_date.present?
          query_array << "#{date_column} <= '#{end_date}'" if end_date.present?

        ########## connection type ####################
        elsif filter_param_type == FilterParam::CONNECTION_TYPE

          # TODO make the column detection in the sql_string more robust
          if fp.selected.present? && sql_string[/([^a-z\d]|^)#{fp.filter_param.column}([^a-z\d]|$)/].present?
            query_array << "#{fp.filter_param.column} = '#{sql_quoted(fp.selected)}'"
          end

        ########## check boxes ####################
        elsif filter_param_type == FilterParam::CHECK_BOXES

          if fp.filter_enabled? && fp.values.present? && sql_string[/([^a-z\d]|^)#{fp.filter_param.column}([^a-z\d]|$)/].present?
            check_box_array = []
            fp.values.each do |key, value|
              if value == '1'
                check_box_array << "#{fp.filter_param.column} = '#{sql_quoted(key)}'"
              end
            end
            check_box_clause = check_box_array.present? ? "(#{check_box_array.join(' OR ')})" : nil
            query_array << check_box_clause if check_box_clause.present?
          end

        elsif filter_param_type == FilterParam::KPI

          # doesn't actually filter the data

        else
          raise "filter_param_type '#{filter_param_type}' unsupported"
        end

      end
    end

    # convert the array to the proper string where/and clause
    if query_array.blank?
      return sql_string.gsub(/\{and_filter\}/, "").gsub(/\{where_filter\}/, "")
    else
      query_expr = query_array.join(' AND ')
      return sql_string.gsub(/\{and_filter\}/, " AND #{query_expr}").gsub(/\{where_filter\}/, " WHERE #{query_expr}")
    end
  end

  # @param [String] mysql query string
  # @param [Hash] can take :sample_option
  # @return [Array<Object>] the result set
  def filtered_results(filter_prefs, filter_set = nil, options = {})
    self.query_result(filter_prefs, filter_set, options)
  end

protected ##################

  def sql_quoted(str)
    ActiveRecord::Base.connection.quote_string(str)
  end

#  def filtered_json_results(filter_prefs, options = {})
#    options ||= {}
#    sample_option = options[:sample_option]
#
#    query_result = self.query_result(filter_prefs, nil, :sample_option => sample_option)
#    latest_data_results = query_result.try(:latest_data_results)
#    if latest_data_results.present?
#      result_data = JSON.load(query_result.latest_data_results[0].data)
#    else
#      result_data = {}
#    end
#
#    query_array = []
#    if filter_prefs.present?
#      filter_prefs.each do |fp|
#        filter_param_type = fp.filter_param.try(:filter_param_type)
#
#        if filter_param_type == 'date' || filter_param_type == 'day'
#
#          case filter_param_type
#            when 'date'
#              date_format = '%Y-%m'
#            when 'day'
#              date_format = '%Y-%m-%d'
#          end
#
#          col_index = result_data['columns'].index(fp.filter_param.column)
#          if fp.period_selected?
#            if fp.period.nil?
#              period = fp.filter_param.default_period
#            else
#              period = fp.period
#            end
#            start_date = (period.nil? ? period.ago : nil)
#            end_date = nil
#          else
#            start_date = fp.start_date.strftime(date_format)
#            end_date = fp.end_date.strftime(date_format)
#          end
#          query_array << "@[#{col_index}] >= '#{start_date}'" if start_date.present?
#          query_array << "@[#{col_index}] <= '#{end_date}'" if end_date.present?
#
#        elsif filter_param_type == 'select'
#
#          col_index = result_data['columns'].index(fp.filter_param.column)
#          # TODO implement
#          values = fp.selected_hash
#          # in Ruby 1.8 this is an array, in Ruby 1.9 it's a hash
#          selected_values = values.select{ |k,v| v == true }
#          sub_query_array = []
#          selected_values.each do |value|
#            # TODO should work if value is a string
#            sub_query_array << "@[#{col_index}] = #{value[0]}"
#          end
#          query_array << "(#{sub_query_array.join(' | ')})" unless sub_query_array.empty?
#
#        elsif filter_param_type == 'query_select'
#          # do nothing since we've already handled these cases in the selected_report_queries method
#        else
#          raise 'other filter_param types are not supported'
#        end
#      end
#    end
#
#    if query_array.blank?
#      return result_data
#    else
#      query_expr = query_array.join(' & ')
#      filtered_data = Siren.query "$[? #{query_expr} ]", result_data['data']
#      filtered_result_data = result_data.clone
#      filtered_result_data['data'] = filtered_data
#      return filtered_result_data
#    end
#  end
end
