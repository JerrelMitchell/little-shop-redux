RSpec.describe 'Visitors' do
  before(:each) do
    @first_item_attrs = { id: 1, title: 'The First Cool Item',
                         description: 'It\'s alright',
                         price: 357, image: 'imgs/img1', merchant_id: 1 }
    @second_item_attrs = { id: 2, title: 'The Second Cool Item',
                           description: 'It\'s cool',
                           price: 1000, image: 'imgs/img2', merchant_id: 2}
    @third_item_attrs = { id: 3, title: 'The Third Cool Item',
                          description: 'It\'s the coolest',
                          price: 900, image: 'imgs/img3', merchant_id: 2 }
    @item1 = Item.create(@first_item_attrs)
    @item2 = Item.create(@second_item_attrs)
    @item3 = Item.create(@third_item_attrs)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
    @merchant2 = Merchant.create(id: 2, name: 'The Sort of Cool Merchant', item_id: 2)
  end

  context 'when visiting /merchants as an anonymous user' do
    it 'should see merchant-dashboard link' do
      link = 'Merchants Dashboard'
      visit('/merchants')

      expect(page).to have_content(link)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    it 'should see all merchants' do

      visit('/merchants-dashboard')

      expect(status_code).to eq(200)
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    it 'should see an item count associated with each merchant' do
      visit('/merchants-dashboard')

      expect(page).to have_content('Item Count')
      expect(page).to have_content(@merchant1.items.count)
      expect(page).to have_content(@merchant2.items.count)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    it 'should see an average item price associated with each merchant' do
      avg_item_price1 = Merchant.average_item_price(@merchant1)
      avg_item_price2 = Merchant.average_item_price(@merchant2)

      visit('/merchants-dashboard')

      expect(page).to have_content('Average Item Price')
      expect(page).to have_content(avg_item_price1)
      expect(page).to have_content(avg_item_price2)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    it 'should see a total cost of items associated with each merchant' do
      total_item_price1 = Merchant.total_item_price(@merchant1)
      total_item_price2 = Merchant.total_item_price(@merchant2)

      visit('/merchants-dashboard')

      expect(page).to have_content('Total Cost of Items')
      expect(page).to have_content(total_item_price1)
      expect(page).to have_content(total_item_price2)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    it 'should see merchant with most items' do
      visit('/merchants-dashboard')

      expect(page).to have_content('Merchant With Most Items:')
      expect(page).to have_content(@merchant1.name)
    end
  end

  context 'when visiting /merchants-dashboard as an anonymous user' do
    xit 'should see merchant with highest item price' do
      visit('/merchants-dashboard')

      expect(page).to have_content('Merchant with Highest Item Price')
      expect(page).to have_content(@merchant2.name)
    end
  end
end
