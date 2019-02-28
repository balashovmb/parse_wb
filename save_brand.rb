require 'open-uri'
require 'nokogiri'
require_relative './save_pics'
require_relative './save_video'
class SaveBrand

  attr_reader :url, :type, :items

  def initialize(url, type='')
    @url = url
    @type = type
    @items = File.open("/home/muxa/Git/parse_wb/files/saved_items").to_a
  end

  def save_pics
    create_dir
    ids = get_ids
    ids.each do |id|
      next if check_saved(id)
      SavePics.new(id, dir_name).save
    end
    Dir.chdir('..')
  end

  def get_ids
    ids = []
    (1..20).each do |page_number|
      current_url = base_url + '?' + 'page=' + page_number.to_s + '&' + query_string
      html = open(current_url)
      doc = Nokogiri::HTML(html)
      elements = doc.css('.dtList')
      elements.each do |el|
        ids_string = el.attribute('data-catalogercod1s').value # можно ли выдрать id без перебора
        ids_array = ids_string.split(',')
        ids += ids_array unless ids.include?(ids_array)
      end
    end
    ids
    rescue OpenURI::HTTPError, OpenSSL::SSL::SSLError, Net::OpenTimeout
      ids
  end

  def dir_name
    if type == 'brand'
      url.split('/')[4]
    else
      url.split('/').last.split('?').first
    end
  end

  def query_string
    url.split('?').length > 1 ? url.split('?').last : ''
  end

  def base_url
    url.split('?').first
  end

  def create_dir
    Dir.mkdir('files') unless File.exists?('files')
    Dir.chdir('files')
    Dir.mkdir(dir_name) unless File.exists?(dir_name)
  end

  def check_saved(id)
    items.include?(id + "\n")
  end
end
