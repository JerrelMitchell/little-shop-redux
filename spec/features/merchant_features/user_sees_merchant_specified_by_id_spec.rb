RSpec.describe 'Visitors' do
  context 'when visiting /merchants/id as an anonymous user' do
    it 'should see specific merchant by its id' do
      merchant_name = 'Ye Newere Shoppe'
      Merchant.create(id: 1, name: merchant_name)

      visit('/merchants/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(merchant_name)
    end
  end
end
