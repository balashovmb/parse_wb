require_relative 'save_brand'

IO.readlines('/home/muxa/Git/parse_wb/brands_list').each do |b|
  puts b.chomp!
  url = "https://www.wildberries.ru/brands/" + b + "/bele?kind=2"
  s = SaveBrand.new(url, 'brand')
  s.save_pics
end