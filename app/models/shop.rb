class Shop < ActiveRecord::Base
  attr_accessible :url

  has_many :items
end
