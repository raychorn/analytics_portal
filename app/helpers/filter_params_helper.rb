module FilterParamsHelper
  #<!-- check_boxes, date, kpi, map, select-->

  def new_check_boxes_filter_param_path
    url_for :controller => 'filter_params', :action => 'new', :filter_param_type => CheckBoxesFilterParam.to_s
  end

  def new_date_filter_param_path
    url_for :controller => 'filter_params', :action => 'new', :filter_param_type => DateFilterParam.to_s
  end

  def new_kpi_filter_param_path
    url_for :controller => 'filter_params', :action => 'new', :filter_param_type => KpiFilterParam.to_s
  end

  def new_map_filter_param_path
    url_for :controller => 'filter_params', :action => 'new', :filter_param_type => MapFilterParam.to_s
  end

  def new_select_filter_param_path
    url_for :controller => 'filter_params', :action => 'new', :filter_param_type => SelectFilterParam.to_s
  end

end
