class ChartReport < Report
  validates :highcharts_params, :json_or_blank => true

  class ChartType
    def self.all
      ALL
    end

    def self.options
      OPTIONS
    end

    SCATTER = 'scatter'

    private #################

    ALL = ['line', 'area', 'areaspline', 'bar', 'column', 'pie', SCATTER, 'spline']

    OPTIONS = ALL.collect { |v| [v, v] }
  end

  # includes options required for highcharts initialization
  def highcharts_params_to_render
    if self.highcharts_params.blank?
      base_params = '{}'
    else
      base_params = self.highcharts_params
    end
    JSON.parse(base_params).merge(
        {
            'chart' => {
                'renderTo' => "report_#{self.id}_content"
            },
            'title' => {'text' => self.name}
        }
    )
  end

  def json_data(column_filter_hash, filter_prefs = nil, filter_set = nil)
    # use the report's filter_prefs if nothing is defined from the dashboard_report
    filter_prefs = self.filter_prefs if filter_prefs.blank?
    filter_set = self.filter_set if filter_set.blank?

    selected_report_queries = selected_report_queries(filter_prefs)

    @series_data ||= selected_report_queries.collect do |report_query|
      # namespace clash with ActiveRecord Query class
      filtered_result_data = report_query.query.filtered_results(
          filter_prefs, filter_set, :sample_option => self.sample_option, :sql_string => report_query.sql_string
      )
      if report_query.chart_params.blank?
        chart_params_json = '{}'
      else
        chart_params_json = report_query.chart_params
      end
      chart_params = JSON.parse(chart_params_json)
      chart_params[:name] = DataParameter.lookup_column_name(report_query.y_column)
      chart_params[:name] ||= report_query.y_column
      chart_params[:type] = report_query.chart_type if report_query.chart_type.present?
      chart_params[:yAxis] = report_query.y_axis
      chart_params[:data] = series_data_array(filtered_result_data, report_query)
      chart_params
    end
    @series_data ||= '[]'
  end

  def series_data=(series_data)
    @series_data = series_data
  end

  def tooltip_formatter
    scatter_report_query = report_queries.where(:chart_type => ChartType::SCATTER).first
    if !scatter_report_query.nil?
      "function() { return '' + this.point.name }"
    else
      'null'
    end
  end

protected ###############################

  # takes in either a data hash or an array
  def series_data_array(data, report_query)
    super(data, :report_query => report_query)
  end
end
