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
    unless params[:site][:full_url] == nil
      full_url = clean_url(params[:site][:full_url])
      @page = open('http://www.'+url+URI::encode(full_url)).read
    else
      @page = open('http://www.'+url).read
    end

    @page.gsub!('href="/','href="http://www.'+url+'/')
    @page.gsub!('src="/','src="http://www.'+url+'/')
    @page.gsub!('target="_blank"','')
    @page.gsub!('href="http://www.'+url,'href="/search/site?'+'site%5Burl%5D='+url+'&site%5Bfull_url%5D=')
    @page = @page.html_safe
    render :layout => false
  end
  
  private

  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def parse
    
  end
end
