require 'open-uri'
require 'nokogiri'
require_relative './save_pics'
require_relative './save_video'
class SaveBrand

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def save_pics
    create_dir
    ids = get_ids
    ids.each do |id|
 #     SavePics.new(id, dir_name).save
      SaveVideo.new(id, dir_name).save
    end
  end

  def get_ids
    ids = []
    (1..20).each do |page_number|
      current_url = base_url + '?' + 'page=' + page_number.to_s + '&' + query_string
      html = open(current_url)
      doc = Nokogiri::HTML(html)
      elements = doc.css('.dtList')
      elements.each do |el|
        ids_string = el.attribute('data-colors').value # можно ли выдрать id без перебора
        ids_array = ids_string.split(',')
        ids += ids_array unless ids.include?(ids_array)
      end
    end
    ids
    rescue OpenURI::HTTPError
      ids
  end

  def dir_name
    url.split('/').last.split('?').first
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
end