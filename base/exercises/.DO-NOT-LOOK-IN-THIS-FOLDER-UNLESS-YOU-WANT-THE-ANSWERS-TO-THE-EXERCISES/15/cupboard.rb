class Cupboard

  attr_accessor :shelf

  def initialize
    @shelf = Location.new
  end

  def stock_shelves
    0.times do
      @shelf.contents << Glass.new
    end
  end

  def find_glass
    @shelf.contents.find { |obj| obj.class == Glass }
  end

end
