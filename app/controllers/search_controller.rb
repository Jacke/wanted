class SearchController < ApplicationController
  def index

  end

  def site
    @site = params[:site][:url]
    #full_url = 'href="http://www.'+@site+'/'
    #require 'open-uri'
    #@page = open('http://www.'+@site).read
    #@page.gsub!('href="/',full_url)
    #full_url = 'src="http://www.'+@site+'/'
    #@page.gsub!('src="/',full_url)
    #File.open(Rails.root+'public/fraim.html', 'w') do |file|
    #  file << @page
    #end
  end
end
