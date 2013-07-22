module DashboardsHelper

  def default_dashboard_path
    default_dashboard = nil
    if current_user    
      default_dashboard = current_user.owned_dashboards.first
    end
    if default_dashboard.present?
      dashboard_path(default_dashboard)
    else
      new_dashboard_path
    end
  end

end
