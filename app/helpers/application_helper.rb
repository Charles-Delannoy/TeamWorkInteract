module ApplicationHelper
  def svg_tag(name)
    render inline: Rails.root.join("app/assets/images/#{name}").read
  end
end
