# Part 1

def product(arr)
  arr.any? ? arr.reduce(1, :*) : 0
end

def max_2_product(arr)
  arr.any? ? product(arr.max(2)) : 0
end

def abs_difference_is_n?(arr, num)
  # edge case handling
  return false unless arr.count > 1
  arr.each {|elem1|
    arr.each {|elem2|
      if (elem1 - elem2).abs == num
        return true
      end
    }
  }
  # no abs difference was found, return false
  false
end

# Part 2

def hello(name)
  'Hello, ' + name.to_s + ' your name has ' + name.length.to_s + ' characters in it.'
end

def starts_with_consonant?(string_input)
  string_input.downcase!
  string_input =~ /^[b-df-hj-np-tv-z].*$/
end

def binary_multiple_of_4?(string_input)
  string_input =~ /(^[01]*00$)|(^0$)/
end

# Part 3
# HINT http://ruby-for-beginners.rubymonstas.org/writing_classes.html
class HardwareStoreInventoryItem
  def initialize(description, barcode, price, on_hand)
    # input validation
    raise ArgumentError unless (description.is_a? String) && !description.empty?
    raise ArgumentError unless (barcode.is_a? String) && !barcode.empty?
    raise ArgumentError unless (on_hand.is_a? Integer) && (on_hand >= 0)
    raise ArgumentError unless (price.is_a? Numeric) && (price > 0.0)
    @description = description
    @barcode = barcode
    @price = price
    @on_hand = on_hand
  end

  # that's so meta
  attr_reader :description
  attr_reader :barcode
  attr_reader :price
  attr_reader :on_hand

  # input validation on setters
  def description=(description)
    raise ArgumentError unless (description.is_a? String) && !description.empty?
    @description = description
  end

  def barcode=(barcode)
    raise ArgumentError unless (barcode.is_a? String) && !barcode.empty?
    @barcode = barcode
  end

  def on_hand=(on__hand)
    raise ArgumentError unless (on_hand.is_a? Integer) && (on_hand >= 0)
    @on_hand = on__hand
  end

  def price=(price)
    raise ArgumentError unless (price.is_a? Numeric) && (price > 0.0)
    @price = price
  end

  def value_of_inventory_as_string
    num_to_string(@price * @on_hand)
  end

  def price_as_string
    num_to_string @price
  end


  private

  # private method??????? I think
  # this method is a little shaky and should probably
  # use a capturing group to validate characters after the decimal point
  def num_to_string(num)
    str = num.round(2).to_s
    if str =~ /^\d+\.\d*$/
      if str =~ /^\d+\.\d$/
        str += '0'
      end
    else
      str += '.00'
    end
    '$' + str
  end
end
