# use require_dependency instead of require if you want it to load each time the class loads in development
require 'modules/combo_table'
require 'navigation/clickable_tabs_builder'
require 'navigation/action_tabs_builder'
require 'modules/analytics_renderer'

class ApplicationController < ActionController::Base

  include AnalyticsRenderer

  protect_from_forgery

  # devise
  before_filter :authenticate_user!

  # cancan
  check_authorization :unless => :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    debugging_msg = <<-DEBUGGING_MSG
    <span style='display:none'>
      subject: #{exception.subject}
      action: #{exception.action.to_s}
    </span>
    DEBUGGING_MSG

    flash[:alert] = "#{exception.message}\n#{debugging_msg}".html_safe
    render 'shared/authorization_error', :status => 403
    # so message doesn't appear twice
    flash.discard
  end

  def readable_dashboards_for_collection
    default_dashboard = Configuration.instance.default_dashboard
    if default_dashboard.present?
      dashboards = [default_dashboard].concat(Dashboard.accessible_by(current_ability).select { |d| default_dashboard.id != d.id })
    else
      dashboards = Dashboard.accessible_by(current_ability)
    end
    dashboards.collect do |d|
      [d.id, "#{d.name} <span class='owner-name'>(#{d.owner.try(:name)})</span> #{default_dashboard.try(:id) == d.id ? '[Default]' : nil}".html_safe]
    end
  end

end
