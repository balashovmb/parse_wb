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
      filename = "./#{dir}/#{name}-#{n}.jpg"
      next if File.exists?(filename)
      open(filename, 'wb') do |file|
        file << open("#{url}-#{n}.jpg").read
      end
    end
    rescue OpenURI::HTTPError
      File.delete(filename)
    rescue Net::OpenTimeout
      retry
  end
end