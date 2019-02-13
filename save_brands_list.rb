require_relative 'save_brand'

class BrandsList

  def parse
    get_brands_list.each do |b|
      puts b.chomp!
      get_groups_list.each do |g|
        url = "https://www.wildberries.ru/brands/" + b + "/" + g.chomp + "?kind=2"
        puts url
        s = SaveBrand.new(url, 'brand')
        s.save_pics
      end
    end
  end

  def get_brands_list
    @brands_list ||= IO.readlines('/home/muxa/Git/parse_wb/brands_list')
  end

  def get_groups_list
    @groups_list ||= IO.readlines('/home/muxa/Git/parse_wb/groups_list')
  end
end

b = BrandsList.new
b.parse