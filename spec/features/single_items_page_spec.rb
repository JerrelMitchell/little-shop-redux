RSpec.describe 'a typical user visits a specific item\'s page' do
  it 'should see the specfiic item title' do
    item_attrs = {id: 1, title: 'The First Cool Item', description: 'It\'s alright', price: 300, image: 'imgs/img1'}
    price = Item.format_price(item_attrs[:price])
    Item.create(item_attrs)

    visit '/items/1'

    within('.item-title') do
      expect(page).to have_content(item_attrs[:title])
    end

    within('.item-price') do
      expect(page).to have_content(price)
  end
end
