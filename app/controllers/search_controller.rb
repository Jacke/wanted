class SearchController < ApplicationController
  def index

  end

  def site
    @site = params[:site][:url]
  end
end
