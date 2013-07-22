class AddTypeToFilterParams < ActiveRecord::Migration
  UPDATE_QUERY = <<-SQL_UPDATE_QUERY
    UPDATE filter_params
      SET type = CASE type
        WHEN 'day_date' THEN 'DateFilterParam'
        WHEN 'month_date' THEN 'DateFilterParam'
        WHEN 'connection_type' THEN 'SelectFilterParam'
        WHEN 'check_boxes' THEN 'CheckBoxesFilterParam'
        WHEN 'kpi' THEN 'KpiFilterParam'
      END
  SQL_UPDATE_QUERY

  def self.up
    rename_column :filter_params, :filter_param_type, :type
    ActiveRecord::Base.connection.execute(UPDATE_QUERY)
  end

  def self.down
    rename_column :filter_params, :type, :filter_param_type
  end
end
