class MailLetter < ActiveRecord::Base
 attr_accessible :user_id, :item_id, :sended
 belongs_to :user
 belongs_to :item
end
