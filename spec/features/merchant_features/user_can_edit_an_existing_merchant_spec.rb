RSpec.describe 'Visitors' do
  context 'when visiting /merchants/id/edit as an anonymous user' do
    it 'should see input area and button to update merchant' do
      merchant_name = 'Ye Olde Shoppe'
      Merchant.create(id: 1, name: merchant_name)

      visit('/merchants/1/edit')
      # find that delete button exists
      # find that input field exists

      expect(status_code).to eq(200)
      expect(page).to have_content(merchant_name)
    end
  end

  context 'when updating a merchant at as an anonymous user' do
    it 'should see updated merchants list after updating merchant' do
      merchant_name = 'Ye Olde Shoppe'
      updated_name  = 'Ye Newere Shoppe'
      Merchant.create(id: 1, name: merchant_name)

      visit('/merchants/1/edit')
      # input text to input field here
      # click_button('Update Merchant')

      # expect(status_code).to eq(200)
      # expect(page).to have_content(updated_name)
      # expect(page).to_not have_content(merchant_name)
    end
  end

  context 'when using Delete button without valid merchant in input field' do
    it 'should see error stating merchant does not exist ' do
      #create merchant
      #test visiting page
      #test entering in invalid/nonexistant merchant and clicking button
      #test entering in no data to input field and clicking button
      #expects content of error message to display
    end
  end
end
