# -*- encoding: utf-8 -*-
class Setting < ActiveRecord::Base

  attr_protected ''

  class << self
    def store
     {
        app_host:                   'hochuli.ru',
        mailto_email:               Rails.env == 'production' ? 'test@mail.com' : 'sergej.shvecov@gmail.com', 
        site_name:                  'Хочули',
        site_description:           '',
        items_per_page:             20,
        comments_per_page:          3,
      }
    end

    # class method missing
    def method_missing(m, *args, &block)  
     store[m]
    end 
  end

end