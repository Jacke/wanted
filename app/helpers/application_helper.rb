#encoding: utf-8
module ApplicationHelper
  def title
    case "#{controller.controller_name}/#{controller.action_name}"
    when "items/new"
      "Новое"
    when "items/popular"
      "Популярное"
    when "users/show"
      @user.name
    else
      ""
    end
  end

  def nav_title
    case "#{controller.controller_name}/#{controller.action_name}"
    when "items/new"
      html = "НОВ<span class='nav_end_word'>ОЕ</span>".html_safe
    when "items/popular"
      html = "ПОПУЛЯРН<span class='nav_end_word'>ОЕ</span>".html_safe
    when "users/show"
      html = "#{@user.name}<span class='nav_end_word'></span>".html_safe
    else
      ""
    end
  end
end
