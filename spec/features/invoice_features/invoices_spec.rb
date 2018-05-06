RSpec.describe 'Visitors' do
  context 'when visiting /invoices' do
    it 'should see a list of invoices' do
      status1 = 'pending'
      merchant_id1 = 12334135
      status2 = 'shipped'
      merchant_id2 = 12334136
      Invoice.create(merchant_id: merchant_id1, status: status1)
      Invoice.create(merchant_id: merchant_id2, status: status2)

      visit('/invoices')

      expect(status_code).to eq(200)
      expect(page).to have_content(status1)
      expect(page).to have_content(status2)
      expect(page).to have_content(merchant_id1)
      expect(page).to have_content(merchant_id2)


    end
  end

  context 'when visiting /invoices/:id' do
    it 'should display the invoice correspoding to :id' do
      status = 'pending'
      merchant_id = 12334135
      Invoice.create(merchant_id: merchant_id, status: status)

      visit('/invoices/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(status)
      expect(page).to have_content(merchant_id)
    end
  end
end