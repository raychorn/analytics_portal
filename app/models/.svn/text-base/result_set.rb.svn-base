class ResultSet < ActiveResource::Base
  self.site = "http://analytics-admin:3001/"

  def column_names_array
    if self.result_type == 'active_record'
      self.column_names
    else # json
      self.latest_data_results.blank? ? [] : self.latest_data_results_hash_0['columns']
    end
  end

  def results_array
    if self.result_type == 'active_record'
      self.results
    else # json
      # return on the latest one for now
      self.latest_data_results.blank? ? [] : self.latest_data_results_hash_0['data']
    end
  end

  def value_at(row_object, col_name)
    if self.result_type == 'active_record'
      row_object.try(:attributes).try(:fetch, col_name, nil)
    else # json
      row_index = self.latest_data_results_hash_0['columns'].index(col_name)
      row_object[row_index]
    end
  end

protected #####################

  def latest_data_results_hash_0
    @latest_data_results_hash_0 ||= JSON.parse(latest_data_results[0])
  end
end
