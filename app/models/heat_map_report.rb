class HeatMapReport < Report

  def json_data(column_filter_hash, filter_prefs, filter_set)
    filter_prefs = self.filter_prefs if filter_prefs.blank?
    filter_set = self.filter_set if filter_set.blank?

    selected_report_queries = selected_report_queries(filter_prefs)

    if self.table_columns.blank?
      filtered_columns = []
    else
      filtered_columns = self.table_columns.strip.split(%r{,\s*})
    end

    results = []
    selected_report_queries.each do |report_query|
      filtered_result_data = report_query.query.filtered_results(
          filter_prefs, filter_set, :sample_option => self.sample_option, :sql_string => report_query.sql_string
      )
      result_set = filtered_result_data.result_set
      result_set.results_array.each do |row|
        row_array = filtered_columns.collect { |col| result_set.value_at(row, col) }
        results << row_array
      end
    end

    { 'columns' => filtered_columns, 'results' => results }.to_json
  end

end
