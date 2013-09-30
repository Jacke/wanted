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
  def mail_set(user)
    user.present? && !(user.email.present?) 
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
      t = @user.name+' - '+@collection.title.to_s
    when "items/show"
      t = @item.name
    when "items/tags"
      t = params[:tag]
    when "users/mentions"
      t = "Упоминания"
    when "users/people"
      t = "Люди"
    when "users/shops"
      t = "Магазины"
    when "registrations/edit"
      t = "Настройки"
    when "search/index"
      t = "Серч"
    when "search/frame"
      t = "Серч"
    when "search/results"
      t = "Серч - " + @query
    when "search/items"
      t = "Серч - " + @query
    when "search/people"
      t = "Серч - " + @query
    when "search/collections"
      t = "Серч - " + @query
    when "search/shops"
      t = "Серч - " + @query
    when "tracking/followers"
      t = "Подписчики"
    when "tracking/followed_by"
      t = "Подписки"
    when "tracking/followed_by_shop"
      t = "Подписки"
    when "tape/index"
      t = "Лента событий"
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
      html = blur_last_word(@user.name).html_safe+' - '+@collection.title.to_s
    when "items/show"
      html = blur_last_word(@item.name).html_safe
    when "items/tags"
      html = blur_last_word(params[:tag].mb_chars.upcase!).html_safe
    when "users/mentions"
      html = "УПОМИНА<span class='nav_end_word'>НИЯ</span>".html_safe
    when "users/people"
      html = "ЛЮ<span class='nav_end_word'>ДИ</span>".html_safe
    when "users/shops"
      html = "МАГАЗИ<span class='nav_end_word'>НЫ</span>".html_safe
    when "registrations/edit"
      html = "НАСТРОЙКИ <span class='nav_end_word'>ПРОФИЛЯ</span>".html_safe
    when "search/index"
      html = "СДЕЛАТЬ <span class='nav_end_word'>СЕРЧ</span>".html_safe
    when "search/frame"
      html = "СДЕЛАТЬ <span class='nav_end_word'>СЕРЧ</span>".html_safe
    when "search/results"
      html = "СЕРЧ - <span class='nav_end_word'>#{@query.mb_chars.upcase}</span>".html_safe
    when "search/items"
      html = "ТОВАРЫ - <span class='nav_end_word'>#{@query.mb_chars.upcase}</span>".html_safe
    when "search/people"
      html = "ЛЮДИ - <span class='nav_end_word'>#{@query.mb_chars.upcase}</span>".html_safe
    when "search/collections"
      html = "КОЛЛЕКЦИИ - <span class='nav_end_word'>#{@query.mb_chars.upcase}</span>".html_safe
    when "search/shops"
      html = "МАГАЗИНЫ - <span class='nav_end_word'>#{@query.mb_chars.upcase}</span>".html_safe
    when "tracking/followers"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСЧИКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСЧИКИ</span>".html_safe
    when "tracking/followed_by"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe
    when "tracking/followed_by_shop"
      @user == current_user ? html = "МОИ <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe : html = "#{@user.name} - <span class='nav_end_word'>ПОДПИСКИ</span>".html_safe
    when "tape/index"
      html = "ЛЕНТА <span class='nav_end_word'>СОБЫТИЙ</span>".html_safe
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
