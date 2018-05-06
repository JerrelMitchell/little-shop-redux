RSpec.describe 'Visitors' do
  context 'when visiting /merchants/id as an anonymous user' do
    it 'should see specific merchant by its id' do
      name1 = 'Ye Newere Shoppe'
      name2 = 'Example Shop'
      Merchant.create(id: 1, name: name1)
      Merchant.create(id: 2, name: name2)

      visit('/merchants/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(name1)
      expect(page).to_not have_content(name2)
    end
  end
end
