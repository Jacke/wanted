class SearchController < ApplicationController
  def index

  end

  def frame
    @site = clean_url(params[:site][:url])
  end

  def site
    require 'open-uri'
    # очищаем url
    url = clean_url(params[:site][:url])
    full_url = 'href="http://www.'+url+'/'

    @page = open('http://www.'+url).read

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
