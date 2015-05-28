module ApplicationHelper
  def main_menu_item(item, options = {})
    default_options = {
      icon:       item,
      name:       item.to_s.titleize,
      path:       item,
      active_for: item
    }

    options = default_options.merge(options)

    classes = []
    classes << "active" if options[:active_for].to_s == params[:controller]

    content_tag(:li, class: classes) do
      link_to options[:path] do
        content_tag(:i, "", class: "fa fa-#{options[:icon]}") + " " + options[:name]
      end
    end
  end
end
