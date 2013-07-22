# the reason we have this here is because a different render method is called for
# the view (in a helper class) versus the controller

module AnalyticsRenderer

  def render_report(object, options = {}, locals = {}, &block)
    render_polymorphic(object, 'reports', options, locals, &block)
  end

  def render_filter_param(object, options = {}, locals = {}, &block)
    render_polymorphic(object, 'filter_params', options, locals, &block)
  end

  private ##########################

  def render_polymorphic(object, plural_path_prefix, options = {}, locals = {}, &block)
    if object.present?
      path_prefix = object.class.to_s.underscore.pluralize
    else
      path_prefix = plural_path_prefix
    end

    if options[:template]
      options[:template] = File.join(path_prefix, options[:template])
    end
    if options[:partial]
      options[:partial] = File.join(path_prefix, options[:partial])
    end
    render(options, locals, &block)
  end

end