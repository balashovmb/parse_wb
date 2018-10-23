require 'open-uri'
require 'nokogiri'
require_relative './save_pics'
class SaveBrand

  attr_reader :name, :main_url

  def initialize(name)
    @name = name
    @main_url = 'https://www.wildberries.ru/brands/' + name
  end

  def save_pics
    create_dir
    ids = get_ids
    ids.each do |id|
      SavePics.new(id, name).save
    end
  end

  def get_ids
    ids = []
    (1..9).each do |page_number|
      html = open(main_url + "?page=#{page_number}")
      doc = Nokogiri::HTML(html)
      elements = doc.css('.dtList')
      elements.each do |el|
        ids_string = el.attribute('data-colors').value # можно ли выдрать id без перебора
        ids += ids_string.split(',')
      end
    end
    rescue OpenURI::HTTPError
    ids
  end

  def create_dir
    Dir.mkdir('files') unless File.exists?('files')
    Dir.chdir('files')
    Dir.mkdir(name) unless File.exists?(name)
  end
end