RSpec.describe 'Items Pages' do
  before(:each) do
    @first_item_attrs = {id: 1, title: 'The First Cool Item', description: 'It\'s alright', price: 300, image: 'imgs/img1'}
    @second_item_attrs = {id: 2, title: 'The Second Cool Item', description: 'It\'s cool', price: 800, image: 'imgs/img2'}
    @third_item_attrs = {id: 3, title: 'The Third Cool Item', description: 'It\'s the coolest', price: 900, image: 'imgs/img3'}
    Item.create(@first_item_attrs)
    Item.create(@second_item_attrs)
    Item.create(@third_item_attrs)
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
        expect(page).to have_content(@first_item_attrs[:price].to_s)
      end

      within('#item-2') do
        expect(page).to have_content(@second_item_attrs[:price].to_s)
      end

      within('#item-3') do
        expect(page).to have_content(@third_item_attrs[:price].to_s)
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
      price = Item.format_price(@first_item_attrs[:price])

      within('.item-information') do
        expect(page).to have_content(Item.format_price(price))
      end
    end

    it 'they should see the item\'s description' do
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(@first_item_attrs[:description])
      end
    end

    it 'they should see the merchant\'s name' do
      merchant = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
      visit '/item/1'

      within('.item-information') do
        expect(page).to have_content(merchant.name)
      end
    end
  end
end
