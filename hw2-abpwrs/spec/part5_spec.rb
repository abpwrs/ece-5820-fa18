require 'part5.rb'
require 'rspec.rb'

describe 'CartesianProduct' do
  it 'must exist [0 points]' do
    expect { CartesianProduct.new(1..2, 3..4) }.not_to raise_error
  end

  it 'must correctly compute the cartesian product' do
    c = CartesianProduct.new(%i[a b c], [1, 2])
    a = []
    c.each { |i| a << i }
    expect(a).to eq([[:a, 1], [:a, 2], [:b, 1], [:b, 2], [:c, 1], [:c, 2]])
  end

  it 'must handle empty sets' do
    c = CartesianProduct.new(%i[a b c], [])
    a = []
    c.each { |i| a << i }
    expect(a).to eq([])

    c = CartesianProduct.new([], %i[a b c])
    a = []
    c.each { |i| a << i }
    expect(a).to eq([])
  end
end
