module ShopParser
  extend ActiveSupport::Concern
  require 'open-uri'

 private
  def shop_fetch(url, host)

    if url == 'wildberries.ru'
    @page = open( 'http://wildberries.ru', "r:ascii-8bit").read
    elsif host == 'www.adidas.ru'
      @page = open('http://www.'+url).read
      @page.gsub!(' = "/', ' = "http://'+host+'/on/')
      @page.gsub!('/swatch/', '/pdp/')
    elsif host == 'www.adidas.com'
      @page = open('http://www.'+url).read
      @page.gsub!(' = "/', ' = "http://'+host+'/on/')
      @page.gsub!('/swatch/', '/pdp/')
      @page.gsub('(/us/cms_content', '(http://'+host+'/us/cms-content')
    elsif host == 'www.wildberries.ru'
      @page = open('http://www.'+url).read
      @page.gsub!('<script type="text/javascript"> if', '<script type="text/javascript"> var img = $("#photo a img").first();$("#photo").prepend(img); if')
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
    # Base rules
    @page.gsub!('href="//', 'href="http://')
    @page.gsub!('src="//', 'src="http://')
    @page.gsub!('href="/','href="http://'+host+'/')
    @page.gsub!('src="/','src="http://'+host+'/')
    @page.gsub!('href="./','href="http://'+host+'/./')
    @page.gsub!('href="?','href="http://'+host+'/?')
    @page.gsub!('target="_blank"','')
end

def clean_url(url)
  s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  s = URI.escape(s)
end

def encode?(object, url)
    begin 
    cleaned = object.dup.force_encoding('UTF-8') 
    unless cleaned.valid_encoding? 
      cleaned = object.encode( 'UTF-8', 'Windows-1251' ) if object.index('windows-1251').present?
      cleaned = object.encode( 'UTF-8', 'ISO-8859-5' )   if object.index('charset=ISO-8859-5').present?
    end 
    object = cleaned 
    rescue EncodingError 
    object.encode!( 'UTF-8', invalid: :replace, undef: :replace )       
    end 
  object 
end

end
