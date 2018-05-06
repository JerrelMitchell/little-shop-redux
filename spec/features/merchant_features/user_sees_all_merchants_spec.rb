RSpec.describe 'Visitors' do
  context 'when visiting /merchants as an anonymous user' do
    it 'should see all merchants in database' do
      name1 = 'Ye Olde Shoppe'
      name2 = 'Ye Newere Shoppe'
      Merchant.create(id: 1, name: name1)
      Merchant.create(id: 2, name: name2)

      visit('/merchants')

      expect(status_code).to eq(200)
      expect(page).to have_content(name1)
      expect(page).to have_content(name2)
    end
  end
end
