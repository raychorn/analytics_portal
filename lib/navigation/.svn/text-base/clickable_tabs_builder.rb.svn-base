class ClickableTabsBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = item_options[:class].to_s.split(" ").push("current").join(" ") if current_tab?(tab)
    content = @context.link_to_unless(current_tab?(tab), name, options, :class => 'name') do
      @context.link_to(name, options, :class => 'name')
    end
    @context.content_tag(:li, content, item_options)
  end

  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end
end