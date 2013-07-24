class SearchController < ApplicationController
  def index
    @item = Item.new
  end

  def frame
    @site = clean_url(params[:site][:url])
  end

  def site
    require 'open-uri'
    # очищаем url
    url = clean_url(params[:site][:url])
    unless params[:site][:full_url] == nil
      full_url = clean_url(params[:site][:full_url])
      @page = open('http://www.'+url+full_url).read
    else
      @page = open('http://www.'+url).read
    end

    @page.gsub!('href="/','href="http://www.'+url+'/')
    @page.gsub!('src="/','src="http://www.'+url+'/')
    @page.gsub!('target="_blank"','')
    @page.gsub!('<a href="http://www.'+url,'<a href="/search/site?'+'site%5Burl%5D='+url+'&site%5Bfull_url%5D=')
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
