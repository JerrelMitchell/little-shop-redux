RSpec.describe Item do
  describe 'Validations' do
    it 'is invalid without a title' do
      item = Item.new(id: '1234567', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')

      expect(item).to_not be_valid
    end

    it 'is invalid without description' do
      item = Item.new(id: 1234567, title: 'Shoes', price: '400_000', image: '/imgs/shoes')

      expect(item).to_not be_valid
    end

    it 'is invalid without a price' do
      item = Item.new(id: 1234567, title: 'Shoes', description: 'really cool shoes', image: '/imgs/shoes')

      expect(item).to_not be_valid
    end

    it 'is invalid without an image URL reference' do
      item = Item.new(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000')

      expect(item).to_not be_valid
    end
  end
  describe 'Class Methods' do
    describe '.all' do
      it 'should have all items accounted for' do
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')
        Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800_000', image: '/imgs/shirt')
        
        expect(Item.all.length).to eq(2)
      end
    end
  end
end
