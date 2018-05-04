RSpec.describe 'a typical user visits the items page' do
  it 'should see a index page with all items listed' do
    
    first_item_attrs = {id: 1, title: 'The First Cool Item', description: 'It\'s alright', price: 300, image: 'imgs/img1'}
    second_item_attrs = {id: 2, title: 'The Second Cool Item', description: 'It\'s cool', price: 800, image: 'imgs/img2'}
    third_item_attrs = {id: 3, title: 'The Third Cool Item', description: 'It\'s the coolest', price: 900, image: 'imgs/img3'}
    Item.create(first_item_attrs)
    Item.create(second_item_attrs)
    Item.create(third_item_attrs)
    
    visit '/items'

    within('#item-1') do
      expect(page).to have_content(first_item_attrs[:title])
      expect(page).to have_content(first_item_attrs[:description])
      expect(page).to have_content(first_item_attrs[:price].to_s)
    end

    within('#item-2') do
      expect(page).to have_content(second_item_attrs[:title])
      expect(page).to have_content(second_item_attrs[:description])
      expect(page).to have_content(second_item_attrs[:price].to_s)
    end

    within('#item-3') do
      expect(page).to have_content(third_item_attrs[:title])
      expect(page).to have_content(third_item_attrs[:description])
      expect(page).to have_content(third_item_attrs[:price].to_s)
    end
  end
end
