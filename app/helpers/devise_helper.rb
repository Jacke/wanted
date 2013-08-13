# -*- encoding: utf-8 -*-
module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert-error">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def flash_error_messages!
    messages = flash.each.map{|type,msg| msg if type == :alert}.join
    return if messages.empty?
    html = <<-HTML
    <div class="">
      <ul>#{messages}</ul>
    </div>
    HTML
    html.html_safe
  end

  def flash_success_messages
    messages = flash.each.map{|type,msg| msg if type == :notice}.join
    return if messages.empty?
    html = <<-HTML
    <div class="alert alert-success fade in">
      <a class="close" data-dismiss="alert" href="#">×</a>
      <ul>#{messages}</ul>
    </div>
    HTML
    html.html_safe
  end

end