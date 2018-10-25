require 'open-uri'
class SaveVideo
  attr_reader :name, :url, :dir

  def initialize(name, dir='files')
    @name = name
    @url = 'http://video.wbstatic.net/video/new/' + name[0..2] + '0000/' + name
    @dir = dir
  end

  def save
    filename = ''
    filename = "./#{dir}/#{name}.mp4"
    return if File.exists?(filename)
    open(filename, 'wb') do |file|
      file << open("#{url}.mp4").read
    end
    rescue OpenURI::HTTPError
      File.delete(filename)
  end
end

