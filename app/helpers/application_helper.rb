require 'modules/analytics_renderer'

module ApplicationHelper
  include AnalyticsRenderer

  # used in display of tables
  def sortable(sort_sym, column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(sort_sym) ? "current #{sort_direction}" : nil
    direction = column == sort_column(sort_sym) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  # used by main-nav
  # tab_classes must be an array of classes
  def last_tab_class(klass, tab_classes)
    tab_classes.last == klass ? 'last' : ''
  end

  def is_global_admin?(user)
    user.try(:global_admin?)
  end

  def contextual_help_path
    help_id = Help.lookup_help_id(controller.controller_name)
    "/help/Analytics_portal_help_CSH.html#{ help_id.blank? ? '' : "##{help_id}" }"
  end

end
