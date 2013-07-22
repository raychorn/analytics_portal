class KpiReport < Report

  def table_data(column_filter_hash, filter_prefs, filter_set)
    # use the report's filter_prefs if nothing is defined from the dashboard_report
    filter_prefs = self.filter_prefs if filter_prefs.blank?

    columns = self.table_columns_array

    if !defined?(@table_results) || @table_results.blank?
      @table_results = []
      filter_prefs.each do |filter_pref|
        report_query = filter_pref.filter_param.report_query
        kpi_result = KpiResult.new(filter_pref, filter_set)

        if kpi_result.do_alert?
          alert_bullet = '<span class="alert-bullet">&#149;</span> '
        else
          alert_bullet = ''
        end

        trend_elem_id = "trend_3_month_chart_#{filter_pref.id}"

        row_hash = {
            'kpi' => filter_pref.name,
            'actual' => "#{alert_bullet}#{kpi_result.last_float_value}",
            'target' => kpi_result.target_float,
            'data' => {
                'trend_elem_id' => trend_elem_id,
                'series_data' => series_data_array(kpi_result.filtered_result_data, filter_pref.filter_param)
            }
        }
        if kpi_result.first_float_value == 0.0
          row_hash['change']= '-'
        else
          change = kpi_result.change
          if (filter_pref.alert_direction == FilterParam::HIGHER_IS_BETTER && change < 100.0) ||
              (filter_pref.alert_direction == FilterParam::LOWER_IS_BETTER && change > 100.0)
            change_class = 'bad'
          else
            change_class = 'good'
          end
          row_hash['change'] = "<span class=\"#{change_class}\">#{change.round(1)}%</span>"
        end
        row_hash['trend_3_month'] = ActionView::Base.new(Rails.configuration.paths.app.views.first).render(
            :partial => 'kpi_reports/trend_3_months_chart', :format => :txt,
            :locals => {:trend_elem_id => trend_elem_id, :result_data => kpi_result.filtered_result_data}
        )

        @table_results << row_hash
      end
    end

    [columns, @table_results]
  end

  def table_columns_array
    ['kpi', 'actual', 'target', 'trend_3_month', 'change', 'data']
  end

  # used by DataTable jquery plugin
  def json_data(column_filter_hash, filter_prefs, filter_set)
    table_data = table_data(column_filter_hash, filter_prefs, filter_set)
    columns_array = table_data[0]
    results_hash = table_data[1]

    results = results_hash.collect do |data_row|
      columns_array.collect do |col_name|
        DataParameter.lookup_display_value(col_name, data_row[col_name])
      end
    end

    # formatted for TableData jquery plugin
    {"aaData" => results}.to_json
  end

  # call this as a delayed job
  def self.send_alert_notifications(options = {})
    options ||= {}
    use_queue = (options[:use_queue] == true)

    kpi_prefs = FilterPref.joins(:filter_param, :user).
        where(:filter_params => {:filter_param_type => FilterParam::KPI}, :filter_prefs => {:enable_email => true})
    # store hash of user objects as keys and kpi_results as values
    users_kpi_results = {}
    kpi_prefs.find_each do |kpi_pref|
      dashboard_report = kpi_pref.optionable
      kpi_result = KpiResult.new(kpi_pref, dashboard_report.dashboard.filter_set)
      if kpi_result.do_alert?
        user = kpi_pref.user
        # don't send alert for kpi prefs that belong to a report
        if dashboard_report.instance_of?(DashboardReport)
          if users_kpi_results[user].present?
            users_kpi_results[user] << kpi_result
          else
            users_kpi_results[user] = [kpi_result]
          end
        end
      end
    end

    users_kpi_results.each do |user, kpi_results|
      if use_queue
        ::AlertMailer.delay.alert_email(user, kpi_results)
      else
        ::AlertMailer.alert_email(user, kpi_results).deliver
      end
    end
  end

  protected ###############################

  def series_data_array(data, filter_param)
    super(data, :filter_param => filter_param)
  end

end
