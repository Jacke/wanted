class SearchController < ApplicationController
  def index
    @item = Item.new
    @collections = current_user.collections
    @collection = Collection.new
  end

  def frame
    @item = Item.new
    @site = clean_url(params[:site][:url])
    @collections = current_user.collections
    @collection = Collection.new
  end

  def site
    require 'open-uri'
    # очищаем url
    url = clean_url(params[:site][:url])
    host = URI.parse( 'http://www.'+url ).host

    @page = open('http://www.'+url).read

    @page.gsub!('href="/','href="http://'+host+'/')
    @page.gsub!('href="./','href="http://'+host+'/./')
    @page.gsub!('href="?','href="http://'+host+'/?')
    @page.gsub!('src="/','src="http://'+host+'/')
    @page.gsub!('target="_blank"','')
    @page = @page.html_safe
    render :layout => false
  end
  
  private

  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
    s = URI.escape(s)
  end

  def parse
    
  end
end
