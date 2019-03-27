# A Dessert top-level class
class Dessert
  def initialize(name, calories)
    raise ArgumentError unless name.is_a? String
    raise ArgumentError unless calories.is_a?(Numeric) && (calories >= 0)
    @name = name
    @calories = calories
  end

  attr_reader :name, :calories

  def name=(name)
    raise ArgumentError unless name.is_a? String
    @name = name
  end

  def calories=(calories)
    raise ArgumentError unless calories.is_a?(Numeric) && (calories >= 0)
    @calories = calories
  end

  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

# A JellyBean class derived from Dessert
class JellyBean < Dessert
  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  attr_accessor :flavor

  def delicious?
    flavor.casecmp('black licorice').zero? ? false : true
  end
end
