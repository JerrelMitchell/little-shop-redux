RSpec.describe LittleShopApp do
  context 'Items' do
    describe 'Page access status' do
      it 'visiting /items should be successful' do
        visit '/items'

        expect(page.status_code).to eq(200)
      end

      it 'visting /items/:id should be successful' do
        Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800_000', image: '/imgs/shirt', merchant_id: 1)
        Merchant.create(id: 1, name: 'The Coolest Merchant', item_id: 1)
        visit '/item/2345678'

        expect(page.status_code).to eq(200)
      end
    end
  end
end
