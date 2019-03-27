require 'part3.rb'
require 'rspec.rb'

describe 'dessert' do
  before(:each) do
    @d = Dessert.new('a', 1)
  end

  it 'must define a constructor [0 points]' do
    expect {Dessert.new('a', 1)}.not_to raise_error
  end

  %i[healthy? delicious?].each do |method|
    it "must define #{method} [0 points]" do
      #      Dessert.new('a',1).should respond_to method
      expect(Dessert.new('a', 1)).to respond_to(method)
    end
  end

  it 'must have a setter for name w/ input validation' do
    expect {@d.name = 'b'}.not_to raise_error
    expect {@d.name = 5}.to raise_error(ArgumentError)
  end

  it 'must have a setter for calories w/ input validation' do
    expect {@d.calories = 100}.not_to raise_error
    expect {@d.calories = -1}.to raise_error(ArgumentError)
    expect {@d.calories = 'this a string oh no'}.to raise_error(ArgumentError)
  end

  it 'must have a getter for name' do
    expect(@d.name).to eq("a")
  end

  it 'must have a getter for calories' do
    expect(@d.calories).to eq(1)
  end


  it 'must have appropriate behavior for #delicious?' do
    expect(@d.delicious?).to be_truthy
  end

  it 'must have appropriate behavior for #healthy?' do
    expect(@d.healthy?).to be_truthy
    @d.calories = 201
    expect(@d.healthy?).to be_falsey
  end

end

describe 'jellybean' do
  before(:each) do
    @j = JellyBean.new('a', 1, 'grape')
  end
  it 'must define a constructor [0 points]' do
    expect {JellyBean.new('a', 1, 2)}.not_to raise_error
  end
  %i[healthy? delicious?].each do |method|
    it "must define #{method} [0 points]" do
      #      JellyBean.new('a',1, 2).should respond_to method
      expect(@j).to respond_to(method)
    end
  end

  it 'must respond appropriately to #delicious' do
    expect(@j.delicious?).to be_truthy
    @j.flavor = 'black licorice'
    expect(@j.delicious?).to be_falsey
  end

  it 'must have a getter and setter' do
    expect(@j.flavor).to eq('grape')
    expect {@j.flavor = 'wild berry'}.not_to raise_error
  end

end
