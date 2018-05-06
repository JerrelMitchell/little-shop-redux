RSpec.describe 'Items Pages' do
  before(:each) do
    @first_item_attrs = { id: 1, title: 'The First Cool Item',
                         description: 'It\'s alright',
                         price: 357, image: 'imgs/img1' } 
    @second_item_attrs = { id: 2, title: 'The Second Cool Item',
                           description: 'It\'s cool',
                           price: 1000, image: 'imgs/img2'}
    @third_item_attrs = { id: 3, title: 'The Third Cool Item',
                          description: 'It\'s the coolest',
                          price: 900, image: 'imgs/img3'}
    Item.create(@first_item_attrs)
    Item.create(@second_item_attrs)
    Item.create(@third_item_attrs)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
    @merchant2 = Merchant.create(id: 2, name: 'The Sort of Cool Merchant', item_id: 2)
    Item.find(1).update(merchant_id: 1)
    Item.find(2).update(merchant_id: 2)
  end

  describe 'a typical user visits the items page' do
    it 'they should see a index page with all items\' titles listed' do
      visit '/items'

      within('#item-1') do
        expect(page).to have_content(@first_item_attrs[:title])
      end

      within('#item-2') do
        expect(page).to have_content(@second_item_attrs[:title])
      end

      within('#item-3') do
        expect(page).to have_content(@third_item_attrs[:title])
      end
    end

    it 'they should see an index page with all items\' descriptions listed' do
      visit '/items'

      within('#item-1') do
        expect(page).to have_content(@first_item_attrs[:description])
      end

      within('#item-2') do
        expect(page).to have_content(@second_item_attrs[:description])
      end

      within('#item-3') do
        expect(page).to have_content(@third_item_attrs[:description])
      end
    end

    it 'they should see an index page with all items\' prices listed' do
      visit '/items'

      within('#item-1') do
        expect(page).to have_content(Item.format_price(@first_item_attrs[:price]).to_s)
      end

      within('#item-2') do
        expect(page).to have_content(Item.format_price(@second_item_attrs[:price]).to_s)
      end

      within('#item-3') do
        expect(page).to have_content(Item.format_price(@third_item_attrs[:price]).to_s)
      end
    end
  end

  describe 'a typical user visits a specific item\'s page' do
    it 'they should see the item\'s title as a heading' do
      visit '/item/1'

      within('.item-metainfo') do
        expect(page).to have_content(@first_item_attrs[:title])
      end
    end

    it 'they should see the item\'s title as a sub-heading' do
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(@first_item_attrs[:title])
      end
    end

    it 'they should see the item\'s price' do
      visit '/item/1'
      price = Item.format_price(@first_item_attrs[:price]).to_s

      within('.item-information') do
        expect(page).to have_content(price)
      end
    end

    it 'they should see the item\'s description' do
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(@first_item_attrs[:description])
      end
    end

    it 'they should see the merchant\'s name' do
      visit '/item/1'

      within('.item-merchant-and-image') do
        expect(page).to have_content(@merchant1.name)
      end
    end
  end

  describe 'a typical user visits the new items page' do
    xit 'they should see a form with a merchant dropdown list' do
      visit '/items/new'

      within('form#new-item') do
        within('#merchant-menu') do
          expect(page).to have_content(@merchant1.name)
          expect(page).to have_content(@merchant2.name)
        end
      end
    end

    xit 'they should see a correct fields' do
      visit '/items/new'

      within('form#new-item') do
        expect(page).to have_content('Title')
        expect(page).to have_content('Description')
        expect(page).to have_content('Price')
        expect(page).to have_content('Image URL')
      end
    end

    xit 'they should be able to enter information, create a new item, and be redirect to index' do
    end
  end
end
