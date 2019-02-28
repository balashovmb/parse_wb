require 'open-uri'

class SaveFilesFromList
  
  attr_reader :files_list

  def initialize(files_list)
    @files_list = files_list
  end

  def save
    files_list.each do |name|
      url = "http://img2.wbstatic.net/big/new/" + name[0..2] + "0000/" + name
      full_name = "/home/muxa/Git/parse_wb/files/files3/#{name}"
      next if File.exists?(full_name)
      open(full_name, "wb") do |file|
        file << open(url).read
      end
    end
  end
end