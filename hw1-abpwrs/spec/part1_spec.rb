require 'ruby_intro'
require 'rspec'

describe 'Ruby intro part 1' do
  describe '#sum' do
    it 'must be defined' do
      expect {product([1, 3, 4])}.not_to raise_error
    end

    it 'returns correct product [20 points]', points: 20 do
      expect(product([1, 2, 3, 4, 5])).to be_a_kind_of Integer
      expect(product([1, 2, 3, 4, 5])).to eq(120)
      expect(product([1, 2, 3, 4, -5])).to eq(-120)
      expect(product([1, 2, 3, 4, -5, 5, -100])).to eq(60_000)
      expect(product([-1])).to eq(-1)
    end

    it 'works on the empty array [10 points]', points: 10 do
      expect {product([])}.not_to raise_error
      expect(product([])).to be_zero
    end
  end

  describe '#max_2_product' do
    it 'must be defined' do
      expect {max_2_product([1, 2, 3])}.not_to raise_error
    end
    it 'returns the correct product [7 points]', points: 7 do
      expect(max_2_product([1, 2, 3, 4, 5])).to be_a_kind_of Integer
      expect(max_2_product([1, -2, -3, -4, -5])).to eq(-2)
    end
    it 'works even if 2 largest values are the same [3 points]', points: 3 do
      expect(max_2_product([1, 2, 3, 3])).to eq(9)
    end
    it 'returns zero if array is empty [10 points]', points: 10 do
      expect(max_2_product([])).to be_zero
    end
    it 'returns value of the element if just one element [10 points]', points: 10 do
      expect(max_2_product([3])).to eq(3)
    end
  end

  describe '#abs_difference_is_n?' do
    it 'must be defined' do
      expect {abs_difference_is_n?([1, 2, 3], 4)}.not_to raise_error
    end
    it 'returns true when any two elements sum to the second argument [30 points]', points: 30 do
      expect(abs_difference_is_n?([1, 2, 3, 4, 5], 4)).to be true
      expect(abs_difference_is_n?([3, 0, 5], 5)).to be true
      expect(abs_difference_is_n?([-1, -2, 3, 4, 5, -8], -12)).to be false
      expect(abs_difference_is_n?([-1, -2, 3, 4, 6, -8], -12)).to be false
    end
    #    for rspec 2.14.1
    # it "returns false for the single element array [5 points]" , points: 5 do
    #   sum_to_n?([1], 1).should be_false
    #   sum_to_n?([3], 0).should be_false
    # end
    # it "returns false for the empty array [5 points]" , points: 5 do
    #   sum_to_n?([], 0).should be_false
    #   sum_to_n?([], 7).should be_false
    # end
    it 'returns false for the single element array [5 points]', points: 5 do
      expect(abs_difference_is_n?([1], 1)).to be false
      expect(abs_difference_is_n?([3], 0)).to be false
    end
    it 'returns false for the empty array [5 points]', points: 5 do
      expect(abs_difference_is_n?([], 0)).to be false
      expect(abs_difference_is_n?([], 7)).to be false
    end
  end
end
