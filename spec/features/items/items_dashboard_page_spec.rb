RSpec.describe 'Items Dashboard' do
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

  describe 'page information' do
    it 'should have a header' do
      visit '/items-dashboard'
      header_title = 'Items Dashboard'

      within('header') do
        expect(page).to have_content(header_title)
      end
    end
  end

  describe 'Total Items' do
    it 'should display the correct total items information on the page' do
      visit '/items-dashboard'

      total = 3
      section_title = 'Total Item Count'

      within('#total-item-count') do
        expect(page).to have_content(section_title)
        expect(page).to have_content(total)
      end
    end
  end

  describe 'Average Item Price' do
    it 'should display the correct average item price information on the page' do
      visit '/items-dashboard'

      average = 7.52
      section_title = 'Average Price Per Item'

      within('#average-item-price') do
        expect(page).to have_content(section_title)
        expect(page).to have_content(average)
      end
    end
  end

  describe 'Items By Age' do
    it 'should display the oldest and newest items titles and headings on the page' do
      visit '/items-dashboard'

      oldest = @item1
      newest = @item3

      within('#items-by-age') do
        within('#newest-item') do
          expect(page).to have_content('Newest')
          expect(page).to have_content(newest.title)
        end
        within('#oldest-item') do
          expect(page).to have_content('Oldest')
          expect(page).to have_content(oldest.title)
        end
      end
    end

    it 'clicking on the newest item should load newest items specific page' do
      visit '/items-dashboard'

      within('#newest-item') do
        click_link(@item3.title)
      end

      expect(current_path).to eq("/item/#{@item3.id}")
      expect(page).to have_content(@item3.title)
    end

    it 'clicking on the oldest item should load oldest items specific page' do
      visit '/items-dashboard'

      within('#oldest-item') do
        click_link(@item1.title)
      end

      expect(current_path).to eq("/item/#{@item1.id}")
      expect(page).to have_content(@item1.title)
    end
  end
end
