class Comment < ActiveRecord::Base
  attr_accessible :content, :item_id, :user_id

   # Relations
  #===============================================================
  belongs_to :user
  belongs_to :item
  has_many  :mentions, dependent: :delete_all

  # Validations
  #===============================================================
  validates :content, presence: true

  # упоминания
  def new_item_comment(item)
    item_comment = self.content.strip_tags.split
    make_comment(item_comment, item)
  end
  def item_comment(item)
    comment = self
    item_comment = comment.content.strip_tags.split
    make_comment(item_comment, false)
    @comment_arr.join(' ') unless @comment_arr.blank?
  end

  def make_comment(item_comment, new_item)
    @mentions = []
    @comment_arr = []
    item_comment.each do |comment_pars|
     user = User.find_by(nickname: comment_pars.gsub('@', '')) if comment_pars.match(/^#/).blank? && comment_pars.match(/^@/).present?
       if user.present?
         @mentions << user.id
         #lkd_comment = comment_pars.gsub('@'+user.nickname, '')
         lkd_comment = comment_pars.gsub('@'+user.nickname,'<a href="'+Rails.application.routes.url_helpers.user_show_path(user)+'">@'+user.nickname+'</a>')
         @comment_arr << lkd_comment
       else
         @comment_arr << comment_pars if comment_pars.match(/^@/).present?
       end
     @comment_arr << comment_pars if comment_pars.match(/^#/).blank? && comment_pars.match(/^@/).blank?
    end
    if new_item.present?
      Comment.new(content: @comment_arr.join(' '), user_id: new_item.user_id, item_id: new_item.id).save unless @comment_arr.blank?
      self.make_mentions
    end
  end

  def make_mentions
    logger.info "mentions #{@mentions}"
    @mentions.each do |id| 
      Mention.new(user_id: id, comment_id: self.id).save
    end if @mentions.present?
  end 


  def comment_tag
    comment = self.content
    comment.gsub!(',', ', ')
    @comment_arr = []
    words_arr = comment.split
    words_arr.each do |word|
      if word.match(/^#/).present?
        word.sub!(/^#/, '').sub!(/,$/, '')
        tag = word.gsub(word,'<a href="/tag/'+word+'">#'+word+'</a>')
        @comment_arr << tag
      end
    end
    @comment_arr.join(' ') unless @comment_arr.blank?
  end

end
