RSpec.describe Item do
  describe 'Validations' do
    it 'is invalid without a title' do
      item = Item.new(id: '1234567', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes', merchant_id: 1)

      expect(item).to_not be_valid
    end

    it 'is invalid without description' do
      item = Item.new(id: 1234567, title: 'Shoes', price: '400_000', image: '/imgs/shoes', merchant_id: 1)

      expect(item).to_not be_valid
    end

    it 'is invalid without a price' do
      item = Item.new(id: 1234567, title: 'Shoes', description: 'really cool shoes', image: '/imgs/shoes', merchant_id: 1)

      expect(item).to_not be_valid
    end

    it 'is invalid without an image URL reference' do
      item = Item.new(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', merchant_id: 1)

      expect(item).to_not be_valid
    end

    it 'is invalid without a merchant id' do
      item = Item.new(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')

      expect(item).to_not be_valid
    end
  end

  before(:each) do
    @item1 = Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800_000', image: '/imgs/shirt', merchant_id: 1)
    @item2 = Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes', merchant_id: 1)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
  end

  describe 'Class Methods' do
    describe '.all' do
      it 'should have all items accounted for' do
        expect(Item.all.length).to eq(2)
      end
    end

    describe '.all_formatted' do
      it 'should return all available items without unit_price formatted for views' do
        expect(Item.all_formatted.map(&:price)).to eq([8000.0, 4000.0])
      end
    end

    describe '.format_price' do
      it 'should return the unit_price as a user-readable price' do
        formatted_price = Item.format_price(Item.find(1234567).price)
        expect(formatted_price).to eq(4000.00)
      end
    end

    describe '.add_item' do
      it 'given a hash, it should create a new item and save it to the database' do
        params = {item: {merchant: 'The Coolest Merchant', title: 'A New Item', description: 'This is a new item', price: '8.99', image_url: 'images/new_image'}}
        item = Item.add_item(params[:item])

        new_item = Item.find(2345679)

        expect(new_item.title).to eq(params[:item][:title])
        expect(new_item.description).to eq(params[:item][:description])
        expect(new_item.price).to eq(params[:item][:price].to_f * 100)
        expect(new_item.image).to eq(params[:item][:image_url])
        expect(new_item.merchant_id).to eq(1)
      end
    end

    describe '.update' do
      it 'should update the item using given item attributes and id should not be updated' do
        params = { item: {title: 'Shirt', description: 'not so cool shirt', price: '300', image: 'imgs/shirt' } }
        Item.update(params[:item])

        item = Item.find(1234567)

        expect(item.title).to eq(params[:item][:title]) 
        expect(item.description).to eq(params[:item][:description]) 
        expect(item.price).to eq(params[:item][:price].to_f) 
        expect(item.image).to eq(params[:item][:image]) 
      end
    end

    describe '.count' do
      it 'should return the total number of items' do

        expect(Item.count).to eq(2)
      end
    end

    describe '.average' do
      it 'should return the average of prices as a float' do

        expect(Item.average(:price)).to eq(600000.0)
      end
    end

    describe '.average_item_price' do
      it 'should return the average item price as a float and divided by 100 for currency format' do
        Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '200', image: '/imgs/shirt')
        Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400', image: '/imgs/shoes')

        expect(Item.average_item_price).to eq(6000.0)
      end
    end

    describe '.order' do
      it 'should return most recently created item when sort created date in descending order' do
        item1 = Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '200', image: '/imgs/shirt')
        item2 = Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400', image: '/imgs/shoes')

        expect(Item.order("created_at DESC").limit(1).first).to eq(item2)
        expect(Item.order("created_at DESC").limit(1).first).to_not eq(item1)
      end

      it 'should return the oldest item when ordering by created date, ascending' do
        item1 = Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '200', image: '/imgs/shirt')
        item2 = Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400', image: '/imgs/shoes')

        expect(Item.order("created_at ASC").limit(1).first).to eq(item1)
        expect(Item.order("created_at ASC").limit(1).first).to_not eq(item2)
      end
    end
  end

  describe 'Instance Methods' do
    describe '.update_item' do
      it 'should be able to update an item, including when given merchant data' do
        # Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400_000', image: '/imgs/shoes')
        # merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
        params = { item: {title: 'Shirt', description: 'not so cool shirt', price: '3.00', image_url: 'imgs/shirt', merchant: @merchant1.name } }
        
        # item = Item.find(1234567)
        
        @item1.update_item(params[:item])

        expect(@item1.title).to eq(params[:item][:title]) 
        expect(@item1.description).to eq(params[:item][:description]) 
        expect(@item1.price).to eq(params[:item][:price].to_f * 100) 
        expect(@item1.image).to eq(params[:item][:image_url]) 
        expect(@item1.merchant_id).to eq(1)
      end
    end
  end
end
