module SearchHelper
  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end
end
