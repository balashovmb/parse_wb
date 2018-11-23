require 'open-uri'
class SavePics
  attr_reader :name, :url, :dir

  def initialize(name, dir='files')
    @name = name
    @url = 'http://img2.wbstatic.net/big/new/' + name[0..2] + '0000/' + name
    @dir = dir
  end

  def save
    filename = ''
    (1..9).each do |n|
      filename = "/home/muxa/Git/parse_wb/files/#{dir}/#{name}-#{n}.jpg"
      next if File.exists?(filename)
      open(filename, 'wb') do |file|
        file << open("#{url}-#{n}.jpg").read
        save_new(filename)
      end
    end
    rescue OpenURI::HTTPError
      File.delete(filename)
    rescue Net::OpenTimeout
      retry
  end

  def save_new(filename)
    FileUtils.cp filename, './new'
  end
end