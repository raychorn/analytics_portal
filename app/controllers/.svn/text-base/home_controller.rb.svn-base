class HomeController < ApplicationController

  # cancan
  skip_authorization_check

  # default_dashboard_path
  # TODO fix me as this is hacky
  include DashboardsHelper

  def index
    redirect_to default_dashboard_path
  end

end
