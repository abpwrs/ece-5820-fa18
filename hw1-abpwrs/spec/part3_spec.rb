require 'ruby_intro.rb'
require 'rspec'

describe 'HardwareStoreInventoryItem' do
  it 'must be defined' do
    expect {HardwareStoreInventoryItem}.not_to raise_error
  end

  describe 'getters and setters' do
    before(:each) do
      @hwitem = HardwareStoreInventoryItem.new('hammer', 'barcode1', 33.8, 2)
    end
    it 'gets description [5 points]', points: 5 do
      expect(@hwitem.barcode).to eq('barcode1')
    end
    it 'gets barcode [5 points]', points: 5 do
      expect(@hwitem.barcode).to eq('barcode1')
    end
    it 'gets price [5 points]', points: 5 do
      expect(@hwitem.price).to eq(33.8)
    end
    it 'gets on_hand [5 points]', points: 5 do
      expect(@hwitem.on_hand).to eq(2)
    end

    it 'changes description [5 points]', points: 5 do
      @hwitem.barcode = 'sledge hammer'
      expect(@hwitem.barcode).to eq('sledge hammer')
    end
    it 'changes barcode [5 points]', points: 5 do
      @hwitem.barcode = 'barcode2'
      expect(@hwitem.barcode).to eq('barcode2')
    end
    it 'changes price [5 points]', points: 5 do
      @hwitem.price = 300.0
      expect(@hwitem.price).to eq(300.0)
    end
    it 'changes on_hand [5 points]', points: 5 do
      @hwitem.on_hand = 3
      expect(@hwitem.on_hand).to eq(3)
    end
  end
  describe 'constructor' do
    it 'rejects invalid description [5 points]', points: 3 do
      expect do
        HardwareStoreInventoryItem.new('', 'barcode1', 25.00,
                                       1003)
      end.to raise_error(ArgumentError)
    end
    it 'rejects invalid barcode [5 points]', points: 5 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', '', 25.00,
                                       1003)
      end.to raise_error(ArgumentError)
    end
    it 'rejects non-string description', points: 2 do
      expect do
        HardwareStoreInventoryItem.new(9999, 'barcode1', 40,
                                       1003)
      end.to raise_error(ArgumentError)
    end

    it 'rejects non-Numeric price', points: 2 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', 'barcode1', '40',
                                       1003)
      end.to raise_error(ArgumentError)
    end

    it 'rejects non-Integer on_hand', points: 2 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', 'barcode1', 40,
                                       '1003')
      end.to raise_error(ArgumentError)
    end

    it 'rejects zero price [5 points]', points: 5 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', 'barcode1', 0,
                                       1003)
      end.to raise_error(ArgumentError)
    end
    it 'rejects negative price [5 points]', points: 2 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', 'barcode1', -5.0,
                                       10_003)
      end.to raise_error(ArgumentError)
    end
    it 'rejects negative on_hand [5 points]', points: 3 do
      expect do
        HardwareStoreInventoryItem.new('Light Bulb', 'barcode1', 5.0,
                                       -1)
      end.to raise_error(ArgumentError)
    end
  end
  describe '#price_as_string' do
    it 'must be defined' do
      expect(HardwareStoreInventoryItem.new('Red Paint', 'barcode1', 10,
                                            200)).to respond_to(:price_as_string)
    end
    it 'displays 33.95 as "$33.95" [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Red Paint', 'barcode11', 33.95,
                                            200).price_as_string).to eq('$33.95')
    end
    it 'displays 1.1 as $1.10 [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Red Paint', 'barcode11', 1.1,
                                            200).price_as_string).to eq('$1.10')
    end
    it 'displays 20 as $20.00 [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Red Paint', 'barcode11', 20,
                                            200).price_as_string).to eq('$20.00')
    end
  end

  describe '#value_of_inventory_as_string' do
    it 'must be defined' do
      expect(HardwareStoreInventoryItem.new('Box of nails', 'barcode1', 10.01,
                                            50)).to respond_to(:value_of_inventory_as_string)
    end
    it 'displays "$500.50" [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Box of nails', 'barcode11', 10.01,
                                            50).value_of_inventory_as_string).to eq('$500.50')
    end
    it 'displays "$1001.00" [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Box of nails', 'barcode11', 20.02,
                                            50).value_of_inventory_as_string).to eq('$1001.00')
    end
    it 'displays $1500.50 [5 points]', points: 5 do
      expect(HardwareStoreInventoryItem.new('Box of nails', 'barcode11', 30.01,
                                            50).value_of_inventory_as_string).to eq('$1500.50')
    end
  end
end
