RSpec.describe 'Visitors' do
  context 'when visiting /merchants as an anonymous user' do
    it 'should see all merchants in database' do
      merchant1 = Merchant.create(id: 1, name: 'Ye Olde Shoppe')
      merchant2 = Merchant.create(id: 2, name: 'Ye Newere Shoppe')

      visit('/merchants')

      expect(status_code).to eq(200)
      expect(page).to have_content(merchant1)
      expect(page).to have_content(merchant2)
    end
  end
end
