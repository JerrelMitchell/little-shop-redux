RSpec.describe 'Visitors' do
  context 'when visiting /merchants/new as an anonymous user' do
    it 'should see input field and submit button' do
      message = 'Create New Merchant'
      visit('/merchants/new')

      expect(status_code).to eq(200)
      expect(page).to have_content(message)
    end
  end

  context 'when visiting merchants/new as an anonymous user' do
    it 'should create a new merchant with a name submitted to input field' do
      # setup name of merchant

      # have name submitted to input field

      # expect page to redirect to index after submission
      # expect new merchant to show in index
    end
  end
end
