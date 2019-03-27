require 'part1.rb'
require 'rspec.rb'

describe '#palindrome?' do
  # HINT https://www.toptenz.net/top-10-famous-palindromes.php
  # HINT http://www.rubyguides.com/2018/07/rspec-tutorial/
  it 'must be defined' do
    expect {palindrome?('Testing')}.not_to raise_error
  end

  it 'must return true for empty strings' do
    expect(palindrome?('')).to be true
  end

  it 'must identify palindromes' do
    ["Madam, I'm Adam", 'A man, a plan, a canal -- Panama', 'A but tuba*', 'A dog! A panic in a pagoda!', '1a23'].each do |string|
      expect(palindrome?(string)).to be true
    end
  end

  it 'must identify non-palindromes' do
    ['hello', '1234abc', '*h_l', '4plow^5', '12&_()^()_&21', "\"this\" one has 'quotes' "].each do |string|
      expect(palindrome?(string)).to be false
    end
  end

end

describe '#count_words' do
  it 'must be defined' do
    expect {count_words('Testing')}.not_to raise_error
  end

  it 'must return a Hash' do
    expect(count_words('Testing').class).to eq(Hash)
  end

  it 'must correctly count repeated words' do
    expect(count_words('a time a place a thing')['a']).to eq 3
    expect(count_words('happy happy happy days happy happy happy days')['happy']).to eq 6
    expect(count_words('happy happy happy days happy happy happy days')['days']).to eq 2
    expect(count_words('pythonistas pythoning with peppy pythons pythons')['pythons']).to eq 2
  end

  it 'must handle quotes' do
    hash = count_words("this \"is a 'string with\" quotes' string")
    expect(hash['string']).to eq 2
    expect(hash['quotes']).to eq 1
    expect(hash['is']).to eq 1
    expect(hash['with']).to eq 1
  end

  it 'must correctly identify contractions' do
    expect(count_words('don\'t leave without me')['don\'t']).to eq 1
    expect(count_words('I haven\'t seen him all week')['haven\'t']).to eq 1
    expect(count_words('his favorite color wasn\'t green')['wasn\'t']).to eq 1

  end
end
