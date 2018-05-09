RSpec.describe 'Visitors' do
  before(:each) do
    @merchant1 = Merchant.create(name: 'Ye Olde Shoppe')
    @merchant2 = Merchant.create(name: 'Example Shop')
  end

  context 'when editing a merchant as an anonymous user' do
    it 'should use new name in input area and button to update merchant' do
      new_name = 'Ye Newere Shoppe'

      visit('/merchants/1/edit')
      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(new_name)

      fill_in 'edit_name', with: new_name
      click_button('Submit')

      expect(status_code).to eq(200)
      expect(page).to have_content(new_name)
      expect(page).to_not have_content(@merchant1.name)
    end
  end

  context 'when on the homepage of /merchants as an anonymous user' do
    it 'should have link connected to new merchant page to create new merchant' do
      visit('/merchants')

      expect(page.has_link?(@merchant1.name)).to be(true)
      expect(page.has_link?(@merchant2.name)).to be(true)
      expect(page.has_button?('Edit')).to be(true)
      expect(page.has_button?('Delete')).to be(true)

      expect(page.has_link?('Not A Link')).to be(false)
      expect(page.has_button?('Not A Button')).to be(false)
    end
  end

  context 'when using Delete link with valid merchant in input field' do
    it 'should no longer see merchant in index' do
      visit('/merchants')
      expect(page).to have_content(@merchant1.name)

      click_button('Delete', match: :first)

      expect(page).to_not have_content(@merchant1.name)
    end
  end
end
