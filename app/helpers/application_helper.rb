#encoding: utf-8
module ApplicationHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def title
    t = ""
    # вывод товаров по полу
    case "#{controller.controller_name}/#{controller.action_name}/#{params[:sex]}"
    when "items/male/1"
      t = "Женское"
    when "items/male/2"
      t = "Мужское"
    when "items/male/3"
      t = "Детское"
    end

    # остальное
    case "#{controller.controller_name}/#{controller.action_name}"
    when "items/new"
      t = "Новое"
    when "items/popular"
      t = "Популярное"
    when "users/show"
      t = @user.name
    when "users/collections"
      t = @user.name+' - Коллекци '
    when "users/collection"
      t = @user.name+' - '+@collection.title
    when "items/show"
      t = @item.name
    when "users/mentions"
      t = "Упоминания"
    when "registrations/edit"
      t = "Настройки"
    when "search/index"
      t = "Серч"
    when "search/frame"
      t = "Серч"
    when "tracking/followers"
      t = "Подписчики"
    when "tracking/followed_by"
      t = "Подписки"
    when "tracking/followed_by_shop"
      t = "Подписки"
    end
    t
  end

  def nav_title
    html = ""
    # вывод товаров по полу
    case "#{controller.controller_name}/#{controller.action_name}/#{params[:sex]}"
    when "items/male/1"
      html = "ЖЕНСК<span class='nav_end_word'>ОЕ</span>".html_safe
    when "items/male/2"
      html = "МУЖСК<span class='nav_end_word'>ОЕ</span>".html_safe
    when "items/male/3"
      html = "ДЕТСК<span class='nav_end_word'>ОЕ</span>".html_safe
    end
    
    case "#{controller.controller_name}/#{controller.action_name}"
    when "items/new"
      html = "НОВ<span class='nav_end_word'>ОЕ</span>".html_safe
    when "items/popular"
      html = "ПОПУЛЯРН<span class='nav_end_word'>ОЕ</span>".html_safe
    when "users/show"
      html = blur_last_word(@user.name).html_safe
    when "users/collections"
      html = blur_last_word(@user.name).html_safe
    when "users/collection"
      html = blur_last_word(@user.name).html_safe+' - '+@collection.title
    when "items/show"
      html = blur_last_word(@item.name).html_safe
    when "users/mentions"
      html = "УПОМИНА<span class='nav_end_word'>НИЯ</span>".html_safe
    when "registrations/edit"
      html = "НАСТРОЙКИ <span class='nav_end_word'>ПРОФИЛЯ</span>".html_safe
    when "search/index"
      html = "Сделать <span class='nav_end_word'>серч</span>".html_safe
    when "search/frame"
      html = "Сделать <span class='nav_end_word'>серч</span>".html_safe
    when "tracking/followers"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСЧИКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСЧИКИ</span>".html_safe
    when "tracking/followed_by"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe
    when "tracking/followed_by_shop"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe
    end
      html
  end

  private

  def blur_last_word(string)
    words = string.split(' ')
    if words.length > 1
      last_word = words.last
      string.sub last_word, "<span class='nav_end_word'>#{last_word}</span>"
    else
      string
    end
  end
end
