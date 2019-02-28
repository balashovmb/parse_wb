require_relative 'save_files_from_list'
require_relative 'files_list'

fl = FilesList.new("/home/muxa/Git/parse_wb/files/files2", "/home/muxa/Git/parse_wb/files/files_list")
files = SaveFilesFromList.new(fl.array_from_file)
files.save

