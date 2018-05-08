RSpec.describe 'Items Pages' do
  before(:each) do
    @item_1_attributes = { id: 1, title: 'The First Cool Item',
                           description: 'It\'s alright',
                           price: 357, image: 'imgs/img1', merchant_id: 1 }
    @item_2_attributes = { id: 2, title: 'The Second Cool Item',
                           description: 'It\'s cool',
                           price: 1000, image: 'imgs/img2', merchant_id: 2 }
    @item_3_attributes = { id: 3, title: 'The Third Cool Item',
                           description: 'It\'s the coolest',
                           price: 900, image: 'imgs/img3', merchant_id: 2 }
    Item.create(@item_1_attributes)
    Item.create(@item_2_attributes)
    Item.create(@item_3_attributes)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
    @merchant2 = Merchant.create(id: 2, name: 'The Sort of Cool Merchant', item_id: 2)
    # Item.find(1).update(merchant_id: 1)
    # Item.find(2).update(merchant_id: 2)
  end

  describe 'a typical user visits the items page' do
    it 'they should see a index page with all items\' titles listed' do
      visit '/items'

      within('#item-1') do
        expect(page).to have_content(@item_1_attributes[:title])
      end

      within('#item-2') do
        expect(page).to have_content(@item_2_attributes[:title])
      end

      within('#item-3') do
        expect(page).to have_content(@item_3_attributes[:title])
      end
    end
    
    it 'they should see an index page with all items\' prices listed' do
      visit '/items'

      within('#item-1') do
        expect(page).to have_content(Item.format_price(@item_1_attributes[:price]).to_s)
      end

      within('#item-2') do
        expect(page).to have_content(Item.format_price(@item_2_attributes[:price]).to_s)
      end

      within('#item-3') do
        expect(page).to have_content(Item.format_price(@item_3_attributes[:price]).to_s)
      end
    end
  end

  describe 'a typical user visits a specific item\'s page' do
    it 'they should see the item\'s title as a heading' do
      visit '/item/1'

      within('.item-metainfo') do
        expect(page).to have_content(@item_1_attributes[:title])
      end
    end

    it 'they should see the item\'s title as a sub-heading' do
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(@item_1_attributes[:title])
      end
    end

    it 'they should see the item\'s price' do
      visit '/item/1'
      price = Item.format_price(@item_1_attributes[:price]).to_s

      within('.item-information') do
        expect(page).to have_content(price)
      end
    end

    it 'they should see the item\'s description' do
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(@item_1_attributes[:description])
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
    it 'they should see a form with a merchant dropdown list' do
      visit '/items/new'

      within('form#new-item') do
        within('#merchant-menu') do
          expect(page).to have_content(@merchant1.name)
          expect(page).to have_content(@merchant2.name)
        end
      end
    end

    it 'they should see a correct fields' do
      visit '/items/new'

      within('form#new-item') do
        expect(page).to have_content('Title')
        expect(page).to have_content('Description')
        expect(page).to have_content('Price')
        expect(page).to have_content('Image URL')
      end
    end

    it 'they should be able to enter information to create a new item, and be redirected to item index' do
      visit '/items/new'
      new_item_attributes = { title: 'A New Item', description: 'A new item\'s description', price: '7.99', image_url: 'images/a_new_image' }

      within('#new-item') do
        select('The Coolest Merchant', from: 'merchant-menu')
        fill_in(id: 'item-title', with: new_item_attributes[:title])
        fill_in(id: 'item-description', with: new_item_attributes[:description])
        fill_in(id: 'item-price', with: new_item_attributes[:price])
        fill_in(id: 'item-image-url', with: new_item_attributes[:image_url])
        click_button(id: 'item-submit')
      end

      expect(current_path).to eq('/items')
      expect(Item.find(4).title).to eq(new_item_attributes[:title])
      expect(Item.find(4).description).to eq(new_item_attributes[:description])
      expect(Item.find(4).price).to eq(new_item_attributes[:price].to_f * 100)
      expect(Item.find(4).image).to eq(new_item_attributes[:image_url])
      expect(Item.find(4).merchant_id).to eq(1)
    end
  end

  it 'they should be able to cancel after filling in fields without creating an item' do
    visit '/items/new'
    new_item_attributes = { title: 'A New Item', description: 'A new item\'s description', price: '7.99', image_url: 'images/a_new_image' }

    within('#new-item') do
      select('The Coolest Merchant', from: 'merchant-menu')
      fill_in(id: 'item-title', with: new_item_attributes[:title])
      fill_in(id: 'item-description', with: new_item_attributes[:description])
      fill_in(id: 'item-price', with: new_item_attributes[:price])
      fill_in(id: 'item-image-url', with: new_item_attributes[:image_url])
      click_link('Cancel')
    end

    expect(Item.all.length).to eq(3)
    expect(current_path).to eq('/items')
  end
end
