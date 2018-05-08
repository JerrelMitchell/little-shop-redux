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
    it 'should display the invoice corresponding to :id' do
      status = 'pending'
      merchant_id = 12334135
      Invoice.create(merchant_id: merchant_id, status: status)

      visit('/invoices/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(status)
      expect(page).to have_content(merchant_id)
    end
  end

  context 'when visiting /invoices/:id/edit' do
    it 'should display current status ' do
      merchant_id = 12334105
      status = 'pending'
      invoice = Invoice.create(merchant_id: merchant_id, status: status)
      content = "Current Status: #{invoice.status}"

      visit('/invoices/1/edit')

      expect(page).to have_content(content)
    end

    it 'should have a form to accept new status' do
      merchant_id = 12334105
      status = 'pending'
      new_status = 'shipped'
      invoice = Invoice.create(merchant_id: merchant_id, status: status)
      content = "Current Status: #{invoice.status}"

      visit('/invoices/1/edit')

      within('#invoice-edit') do
        fill_in("invoice[status]", with: new_status)
        click_on('Create Invoice')
      end
      expect(Invoice.find(1).status).to eq(new_status)
      expect(Invoice.find(1).merchant_id).to eq(merchant_id)
    end

    it 'should redirect user to /invoices/:id after editing' do
      merchant_id = 12334105
      status = 'pending'
      new_status = 'shipped'
      invoice = Invoice.create(merchant_id: merchant_id, status: status)

      visit('/invoices/1/edit')

      within('#invoice-edit') do
        fill_in("invoice[status]", with: new_status)
        click_on('Create Invoice')
      end
      expect(current_path).to eq('/invoices/1')
    end
  end
end