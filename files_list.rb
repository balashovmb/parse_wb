class FilesList

  attr_reader :path, :list

  def initialize(path: '', list: '') # переделать передачу аргументов на хеш 
    @path = path
    @list = list
  end

  def save_to_file
    f = File.open(list, "a+") { |f| f << dir_to_array }
  end

  def dir_to_array
    Dir.open(path).entries
  end

  def array_from_file
    files_list = File.open(list, "r").read.delete('"[] ').split(',')
    files_list.delete('.').delete('..')
    puts files_list
    files_list
  end
end

fl = FilesList.new(path: "/home/muxa/Git/parse_wb/files/files2", list: "/home/muxa/Git/parse_wb/files/files_list")
fl.array_from_file