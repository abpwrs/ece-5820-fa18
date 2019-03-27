# Top level CartesianProduct class for testing Enumerables
class CartesianProduct
  include Enumerable

  def initialize(a, b)
    @a = a
    @b = b
  end

  def each
    @a.each { |i| @b.each { |j| yield [i, j] } }
  end
end
