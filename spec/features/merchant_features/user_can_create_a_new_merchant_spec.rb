RSpec.describe 'Visitors' do
  context 'when visiting /merchants/new as an anonymous user' do
    it 'should see input field and submit button' do
      message = 'Create New Merchant'
      visit('/merchants/new')

      expect(status_code).to eq(200)
      expect(page).to have_content(message)
    end
  end

  context 'when visiting /merchants as an anonymous user' do
    it 'should see and be able to click a link to create a new merchant' do
      homepage_message          = 'Create A New Merchant'
      new_merchant_page_message = 'Create New Merchant'
      visit('/merchants')

      expect(page.has_link?(homepage_message)).to be(true)
      expect(page.has_link?('Not A Link')).to be(false)

      click_link(homepage_message)

      expect(page).to have_content(new_merchant_page_message)
      expect(page).to_not have_content(homepage_message)
    end
  end

  context 'when visiting merchants/new as an anonymous user' do
    it 'should create a new merchant with a name submitted to input field' do
      name = 'Ye Newere Shoppe'

      visit('/merchants')
      expect(page).to_not have_content(name)

      click_link('Create A New Merchant')

      fill_in 'new_name', with: name
      click_button('Create Merchant')

      expect(status_code).to eq(200)
      expect(page).to have_content(name)
    end
  end
end
