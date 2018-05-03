RSpec.describe Item do
  describe 'Validations' do
    it 'is invalid without a title' do
      Item.create(id: 1234567, description: 'really cool shoes', price: '400_000', image: 'an image of shoes')

      expect(Item.find(1234567)).to_not be_valid
    end

    it 'is invalid without description' do
      Item.create(id: 1234567, title: 'Shoes', price: '400_000', image: 'an image of shoes')

      expect(Item.find(1234567)).to_not be_valid
    end

    it 'is invalid without a price' do
      Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', image: 'an image of shoes')

      expect(Item.find(1234567)).to_not be_valid
    end

    it 'is invalid without an image URL reference' do
      Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000')

      expect(Item.find(1234567)).to_not be_valid
    end
  end
  describe 'Class Methods' do
    describe '.all' do
      it 'should have all merchants accounted for' do
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: 'an image of shoes')

        expect(Item.all.length).to eq(800)
      end
    end
  end
end