require 'part4.rb'
require 'rspec.rb'

# 30% of total
describe 'single attr_accessor_with_history' do
  before(:each) do
    class Foo
      attr_accessor_with_history :test_var

      def initialize(a)
        @test_var = a
      end
    end
    class Bar
      attr_accessor_with_history :test_var
      attr_accessor_with_history :second_var
    end
    @foo_arr = Foo.new([1, 2, 3, 4])
    @foo_str = Foo.new('test')
    @foo_num = Foo.new(1.1)
    @bar = Bar.new
  end

  # HINT: a before(:each) clause might make the testign code more DRY
  it 'must have an attr_accessor_with_history method [0 point]' do
    expect(-> {Class.new.attr_accessor_with_history :x}).not_to raise_error
  end

  it 'must track any number of changes to vars' do
    @foo_str.test_var = 5
    @foo_num.test_var = 'str'
    @foo_arr.test_var = 3.14
    @bar.test_var = 3
    @bar.test_var = 4

    expect(@foo_arr.test_var_history).to eq([[1, 2, 3, 4], 3.14])
    expect(@foo_str.test_var_history).to eq(['test', 5])
    expect(@foo_num.test_var_history).to eq([1.1, 'str'])
    expect(@bar.test_var_history).to eq([nil, 3, 4])
  end

  it 'must track variables independently' do
    @bar.test_var = 'i like tests'
    @bar.second_var = 'i hate tests'
    @bar.test_var = 1
    @bar.second_var = -1
    expect(@bar.test_var_history).to eq([nil, 'i like tests', 1])
    expect(@bar.second_var_history).to eq([nil, 'i hate tests', -1])
  end

end
