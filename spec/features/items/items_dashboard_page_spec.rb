RSpec.describe 'Items Dashboard' do
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
    @item1 = Item.create(@first_item_attrs)
    @item2 = Item.create(@second_item_attrs)
    @item3 = Item.create(@third_item_attrs)
    @merchant1 = Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
    @merchant2 = Merchant.create(id: 2, name: 'The Sort of Cool Merchant', item_id: 2)
    @item1.update(merchant_id: 1)
    @item2.update(merchant_id: 2)
    @item3.update(merchant_id: 2)
  end

  describe 'page information' do
    it 'should have a header' do
      visit '/items-dashboard'
      header_title = 'Items Dashboard'

      within('header') do
        expect(page).to have_content(header_title)
      end
    end
  end

  describe 'average' do
    it 'should display the correct average information on the page' do
      visit '/items-dashboard'

      average = 7.52
      section_title = 'Total Item Count'

      within('#total-item-count') do
        expect(page).to have_content(section_title)
        expect(page).to have_content(average)
      end
    end
  end
end
