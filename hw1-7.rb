class CartesianProduct
  include Enumerable

  def initialize(xs, ys)
    @xs = xs
    @ys = ys
  end

  def each
    return to_enum unless block_given?
    @xs.each do |x| 
      @ys.each { |y| yield [x, y] }
    end
  end
end
