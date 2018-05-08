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
        Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800_000', image: '/imgs/shirt')
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')

        expect(Item.all.length).to eq(2)
      end
    end

    describe '.all_formatted' do
      it 'should return all available items without unit_price formatted for views' do
        Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800_000', image: '/imgs/shirt')
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')

        expect(Item.all_formatted.map(&:price)).to eq([8000.0, 4000.0])
      end
    end

    describe '.format_price' do
      it 'should return the unit_price as a user-readable price' do
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')
        formatted_price = Item.format_price(Item.find(1234567).price)

        expect(formatted_price).to eq(4000.00)
      end
    end

    describe '.add_item' do
      it 'given a hash, it should create a new item and save it to the database' do
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')
        Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
        params = {item: {merchant: 'The Coolest Merchant', title: 'A New Item', description: 'This is a new item', price: '8.99', image_url: 'images/new_image'}}
        Item.add_item(params[:item])


        expect(Item.find(1234568).title).to eq(params[:item][:title])
        expect(Item.find(1234568).description).to eq(params[:item][:description])
        expect(Item.find(1234568).price).to eq(params[:item][:price].to_f * 100)
        expect(Item.find(1234568).image).to eq(params[:item][:image_url])
        expect(Item.find(1234568).merchant_id).to eq(1)
      end
    end
  end
end
