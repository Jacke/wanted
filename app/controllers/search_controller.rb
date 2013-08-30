class SearchController < ApplicationController
  include ShopParser
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
    url = clean_url(params[:site][:url])
    host = URI.parse( 'http://www.'+url ).host
    unless url.present? || params[:site].blank?
      redirect_to search_url
    end

    shop_fetch(url, host)
    @page = @page.html_safe

    render :layout => false
  end

  def results
    @query = params[:search][:q]
    redirect_to search_url if @query.blank?
    @items = Item.search @query, :page => 1, :per_page => 10, :order => 'raiting DESC'
    @items_count = Item.search_count @query

    @shops = User.search @query, :page => 1, :per_page => 10, :order => 'items_count DESC', :conditions => { :shop => 1 }
    @shops_count = User.search_count @query, :conditions => { :shop => 1 }

    @users = User.search @query, :page => 1, :per_page => 10, :order => 'followers_counter DESC', :conditions => { :shop => 0 }
    @users_count = User.search_count @query, :conditions => { :shop => 0 }

    @collections = Collection.search @query, :page => 1, :per_page => 10
    @collections_count = Collection.search_count @query
  end

  def items
    @query = params[:query]
    @items = Item.search @query, :page => 1, :per_page => 20, :order => 'raiting DESC'
  end

  def shops
    @query = params[:query]
    @shops = User.search @query, :page => 1, :per_page => 20, :order => 'items_count DESC', :conditions => { :shop => 1 }
  end

  def people
    @query = params[:query]
    @users = User.search @query, :page => 1, :per_page => 20, :order => 'followers_counter DESC', :conditions => { :shop => 0 }
  end

  def collections
    @query = params[:query]
    @collections = Collection.search @query, :page => 1, :per_page => 10
  end
  
 
end
