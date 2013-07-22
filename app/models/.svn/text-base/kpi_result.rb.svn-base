class KpiResult
  attr_reader :kpi_pref, :filtered_result_data , :result_set, :last_float_value, :first_float_value, :target_float,
      :change

  def initialize(kpi_pref, filter_set)
    @kpi_pref = kpi_pref
    report_query = @kpi_pref.filter_param.report_query
    report = report_query.report
    filter_prefs = report.filter_prefs
    @filtered_result_data = report_query.query.filtered_results(
        filter_prefs, filter_set, :sample_option => report.sample_option, :sql_string => report_query.sql_string
    )
    @result_set = @filtered_result_data.result_set

    @last_float_value = @result_set.value_at(@result_set.results_array.last,
                                     @kpi_pref.filter_param.column).to_f
    @first_float_value = @result_set.value_at(@result_set.results_array.first,
                                      @kpi_pref.filter_param.column).to_f
    @target_float = @kpi_pref.target.to_f

    @change = (100.0 * (@last_float_value - @first_float_value) /
              @first_float_value)
  end

  def do_alert?
    (@kpi_pref.alert_direction == FilterParam::HIGHER_IS_BETTER && @last_float_value < @target_float) ||
        (@kpi_pref.alert_direction == FilterParam::LOWER_IS_BETTER && @last_float_value > @target_float)
  end

end