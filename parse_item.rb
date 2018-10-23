require_relative 'save_pics'
name = ARGV[0]
s = SavePics.new(name)
s.save