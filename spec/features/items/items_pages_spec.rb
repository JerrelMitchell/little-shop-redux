RSpec.describe 'Items Pages' do
  before(:each) do
    @first_item_attrs = { id: 1, title: 'The First Cool Item',
                         description: 'It\'s alright',
                         price: 357, image: 'imgs/img1' }
    @second_item_attrs = { id: 2, title: 'The Second Cool Item',
                           description: 'It\'s cool',
                           price: 1000, image: 'imgs/img2' }
    @third_item_attrs = { id: 3, title: 'The Third Cool Item',
                          description: 'It\'s the coolest',
                          price: 900, image: 'imgs/img3' }
    @item1 = Item.create(@first_item_attrs)
    @item2 = Item.create(@second_item_attrs)
    @item3 = Item.create(@third_item_attrs)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
    @merchant2 = Merchant.create(id: 2, name: 'The Sort of Cool Merchant', item_id: 2)
    @item1.update(merchant_id: 1)
    @item2.update(merchant_id: 2)
    @item3.update(merchant_id: 2)
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
      new_item_attrs = { title: 'A New Item', description: 'A new item\'s description', price: '7.99', image_url: 'images/a_new_image' }

      within('#new-item') do
        select('The Coolest Merchant', from: 'merchant-menu')
        fill_in(id: 'item-title', with: new_item_attrs[:title])
        fill_in(id: 'item-description', with: new_item_attrs[:description])
        fill_in(id: 'item-price', with: new_item_attrs[:price])
        fill_in(id: 'item-image-url', with: new_item_attrs[:image_url])
        click_button(id: 'item-submit')
      end

      item = Item.find(4)

      expect(current_path).to eq('/items')
      expect(item.title).to eq(new_item_attrs[:title])
      expect(item.description).to eq(new_item_attrs[:description])
      expect(item.price).to eq(new_item_attrs[:price].to_f * 100)
      expect(item.image).to eq(new_item_attrs[:image_url])
      expect(item.merchant_id).to eq(1)
    end

    it 'they should be able to cancel after filling in fields without creating an item' do
      visit '/items/new'
      new_item_attrs = { title: 'A New Item', description: 'A new item\'s description', price: '7.99', image_url: 'images/a_new_image' }

      within('#new-item') do
        select('The Coolest Merchant', from: 'merchant-menu')
        fill_in(id: 'item-title', with: new_item_attrs[:title])
        fill_in(id: 'item-description', with: new_item_attrs[:description])
        fill_in(id: 'item-price', with: new_item_attrs[:price])
        fill_in(id: 'item-image-url', with: new_item_attrs[:image_url])
        click_link('Cancel')
      end

      expect(Item.all.length).to eq(3)
      expect(current_path).to eq('/items')
    end
  end

  describe 'a typical user visits the edit page for an item' do
    it 'they should be able to fill out the fields and update the item' do
      visit '/item/1/edit'

      edited_attrs = { title: 'An Edited Item', description: 'This is an edited item', price: '1.99', image_url: 'images/edited_item'}

      within('#edit-item') do
        select(@merchant1.name, from: 'merchant-menu')
        fill_in(id: 'edit-title', with: edited_attrs[:title])
        fill_in(id: 'edit-description', with: edited_attrs[:description])
        fill_in(id: 'edit-price', with: edited_attrs[:price])
        fill_in(id: 'edit-image-url', with: edited_attrs[:image_url])
        click_button(id: 'submit-edit')
      end

      item = Item.find(1)

      expect(current_path).to eq('/item/1')
      expect(item.merchant_id).to eq(1)
      expect(item.title).to eq(edited_attrs[:title])
      expect(item.description).to eq(edited_attrs[:description])
      expect(item.price).to eq(edited_attrs[:price].to_f * 100)
      expect(item.image).to eq(edited_attrs[:image_url])
    end

    it 'they should be able to fill out the fields, click cancel, and return to the specific item\'s page' do
      visit '/item/1/edit'

      edited_attrs = { title: 'An Edited Item', description: 'This is an edited item', price: '1.99', image_url: 'images/edited_item'}

      within('#edit-item') do
        select(@merchant1.name, from: 'merchant-menu')
        fill_in(id: 'edit-title', with: edited_attrs[:title])
        fill_in(id: 'edit-description', with: edited_attrs[:description])
        fill_in(id: 'edit-price', with: edited_attrs[:price])
        fill_in(id: 'edit-image-url', with: edited_attrs[:image_url])
        click_link(id: 'edit-cancel')
      end

      item = Item.find(1)

      expect(current_path).to eq('/item/1')
      expect(item.merchant_id).to eq(1)
      expect(item.title).to eq(@first_item_attrs[:title])
      expect(item.description).to eq(@first_item_attrs[:description])
      expect(item.price).to eq(@first_item_attrs[:price].to_f)
      expect(item.image).to eq(@first_item_attrs[:image])
    end
  end

  describe 'a typical user deletes and item from the index or show pages' do
    it 'they should be able to delete an item from /items' do
      visit '/items'

      expect(Item.find(1)).to eq(@item1)

      within('#delete-item-1') do
        click_button('Delete')
      end

      expect { Item.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(current_path).to eq('/items')
      expect(page).to_not have_content(@item1.title)
    end

    it 'they should be able to delete an item from the specific item\'s page' do
      visit '/item/1'

      expect(Item.find(1)).to eq(@item1)

      within('#delete-item-1') do
        click_button('Delete')
      end

      expect { Item.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(current_path).to eq('/items')
      expect(page).to_not have_content(@item1.title)
    end
  end

end
