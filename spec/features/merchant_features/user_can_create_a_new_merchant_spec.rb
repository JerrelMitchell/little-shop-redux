RSpec.describe 'Visitors' do
  context 'when visiting /merchants/new as an anonymous user' do
    it 'should be able to create new merchant' do
      message = 'Create New Merchant'
      visit('/merchants/new')

      expect(status_code).to eq(200)
      expect(page).to have_content(message)
    end
  end
end
