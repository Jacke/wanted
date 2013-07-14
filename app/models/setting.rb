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

      }
    end

    # class method missing
    def method_missing(m, *args, &block)  
     store[m]
    end 
  end

end