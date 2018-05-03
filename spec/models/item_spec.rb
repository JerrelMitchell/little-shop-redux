RSpec.describe Item do
  describe 'Class Methods' do
    describe '.all' do
      it 'should have all merchants accounted for' do
        Item.create(title: 'Shoes', description: 'really cool shoes', price: '400_000', image: 'an image of shoes')

        expect(Item.all.length).to eq(800)
      end
    end
  end
end