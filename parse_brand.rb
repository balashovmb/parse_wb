require_relative 'save_brand'
name = ARGV[0]
s = SaveBrand.new(name)
s.save_pics