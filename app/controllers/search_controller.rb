class SearchController < ApplicationController
  def index

  end

  def site
    #@site = clean_url(params[:site][:url])
    #full_url = 'href="http://www.'+@site+'/'
    #require 'open-uri'
    #@page = open('http://www.'+@site).read
    #@page.gsub!('href="/',full_url)
    #full_url = 'src="http://www.'+@site+'/'
    #@page.gsub!('src="/',full_url)
    #@page.gsub!('target="_blank"','')
    #@page.gsub!('<a href="http://www.','<a href="/go/site?'+'site%5Burl%5D='+@site+'&site%5Bfull_url%5D=')
    #@page = @page.dup.force_encoding('UTF-8')#sthash.JAbhtVv9.dpuf
    #File.open(Rails.root+'public/fraim.html', 'w') do |file|
     # file << @page
    #end
  end

  def redirect
    @site = clean_url(params[:site][:url])
    @full_site = clean_url(params[:site][:full_url])
    full_url = 'href="http://www.'+@site+'/'
    require 'open-uri'
    @page = open('http://www.'+@full_site).read
    @page.gsub!('href="/',full_url)
    full_url = 'src="http://www.'+@site+'/'
    @page.gsub!('src="/',full_url)
    @page.gsub!('target="_blank"','')
    @page.gsub!('<a href="http://www.','<a href="/go/site?'+'site%5Burl%5D='+@site+'&site%5Bfull_url%5D=')
    @page = @page.dup.force_encoding('UTF-8')#sthash.JAbhtVv9.dpuf
    File.open(Rails.root+'public/fraim.html', 'w') do |file|
      file << @page
    end
    redirect_to '/fraim.html'
  end

  def frame
    @site = clean_url(params[:site][:url])
  end
  
  private

  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end
end
