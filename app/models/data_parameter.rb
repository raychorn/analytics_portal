class DataParameter < ActiveResource::Base
  self.site = 'http://analytics-admin:3001'

  DATA_PARAMETERS_KEY = 'data_parameters'

  private_class_method :all

  def self.all_cached
    begin
      Rails.cache.fetch(DATA_PARAMETERS_KEY, :expires_in => 5.minutes, :race_condition_ttl => 5) do
        # note can't do self.all because it's a private class method, but this works
        all || []
      end
    rescue Errno::ECONNREFUSED, Errno::EACCES => e
      Rails.logger.warn "Connecting to admin web service failed:"
      Rails.logger.warn e.inspect
      return []
    end
  end

  # data_param_field = which attribute of data_parameter to look at (string or symbol)
  # data_param_key = the key to lookup in data_param_field
  def self.lookup_by(data_param_field, data_param_key)
    return nil if data_param_key.blank?
    all_cached.each do |data_parameter|
      return data_parameter if data_param_key == data_parameter.try(data_param_field.to_sym)
    end
    return nil
  end

  def self.lookup_column_name(column_name, row_value = nil)
    if row_value.nil?
      return self.lookup_by(:column_name, column_name).try(:display_name) || column_name
    else
      value_mappings = self.lookup_by(:column_name, column_name).try(:value_mappings)
      if value_mappings.blank?
        return row_value
      else
        row_value_display_name = row_value
        row_value_str = row_value.to_s
        value_mappings.each do |value_mapping|
          if value_mapping.key == row_value_str
            row_value_display_name = value_mapping.value
            break
          end
        end
        return row_value_display_name
      end
    end
  end


  def self.lookup_display_value(column_name, row_value = nil)
    if row_value.nil?
      return ''
    else
      value_mappings = self.lookup_by(:column_name, column_name).try(:value_mappings)
      if value_mappings.blank?
        return row_value
      else
        row_value_display_name = row_value
        row_value_str = row_value.to_s
        value_mappings.each do |value_mapping|
          if value_mapping.key == row_value_str
            row_value_display_name = value_mapping.value
            break
          end
        end
        return row_value_display_name
      end
    end
  end
end