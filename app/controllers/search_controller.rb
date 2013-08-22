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
    logger.info host
    if url == 'wildberries.ru'
    @page = open( 'http://wildberries.ru', "r:ascii-8bit").read
    logger.info "BAAAAAAND =>>>>>>"
    elsif host == 'www.adidas.ru'
      @page = open('http://www.'+url).read
      @page.gsub!(' = "/', ' = "http://'+host+'/on/')
      @page.gsub!('/swatch/', '/pdp/')
    elsif host == 'www.lamoda.ru'
      @page = open('http://www.'+url).read
      @page.gsub!('overlay_all ', '')
      @page.gsub!(/overlay_all_var\d/, 'none')
      @page.gsub!(' class="veil" id="veilpop"', '')
      @page.gsub!(' class="full-veil"', '')
    else
      @page = open('http://www.'+url).read
    end
      @page = encode?(@page, url) unless host == 'img1.wildberries.ru'    

    # if ...
    @page.gsub!('href="//', 'href="http://')
    @page.gsub!('src="//', 'src="http://')
    @page.gsub!('href="/','href="http://'+host+'/')
    @page.gsub!('src="/','src="http://'+host+'/')
    @page.gsub!('href="./','href="http://'+host+'/./')
    @page.gsub!('href="?','href="http://'+host+'/?')
    @page.gsub!('target="_blank"','')

    @page = @page.html_safe

    render :layout => false
  end

  def results
    @query = params[:search][:q]

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
  
  private

  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
    s = URI.escape(s)
  end
  
  def encode?(object, url)
    logger.info "#{object.encoding} true?"
      logger.info "............................"
      begin 
      cleaned = object.dup.force_encoding('UTF-8') 
      unless cleaned.valid_encoding? 
      cleaned = object.encode( 'UTF-8', 'Windows-1251' ) 
      end 
      object = cleaned 
      rescue EncodingError 
      object.encode!( 'UTF-8', invalid: :replace, undef: :replace )       
      end 
      #object.sub!(/(?<=(\<meta charset\="))(.+?)(?=".+?\>)/, 'utf-8')
      logger.info "puuuuuuuuuul"
    object 
  end

  def parse
    
  end
end
