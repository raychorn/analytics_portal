module ReportsHelper

  def new_chart_report_path
    url_for :controller => 'reports', :action => 'new', :report_type => ChartReport.to_s
  end

  def new_table_report_path
    url_for :controller => 'reports', :action => 'new', :report_type => TableReport.to_s
  end

  def new_heat_map_report_path
    url_for :controller => 'reports', :action => 'new', :report_type => HeatMapReport.to_s
  end

  def new_kpi_report_path
    url_for :controller => 'reports', :action => 'new', :report_type => KpiReport.to_s
  end

end
