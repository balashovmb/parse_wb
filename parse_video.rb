require_relative 'save_video'
name = ARGV[0]
s = SaveVideo.new(name)
s.save
