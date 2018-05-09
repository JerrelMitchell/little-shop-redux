RSpec.describe 'Visitors' do
   before(:each) do
      @invoice1 = Invoice.create(merchant_id: 12334111, status: 'pending')
      @invoice2 = Invoice.create(merchant_id: 12334112, status: 'shipped')
      @invoice3 = Invoice.create(merchant_id: 12334113, status: 'returned')
      @merchant1 = Merchant.create(id: 12334111, name: 'Ye Olde Shoppe')
      @merchant2 = Merchant.create(id: 12334112, name: 'Example Shop')
    end

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
      visit('/invoices/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.merchant_id)
    end

    xit 'should display the merchant name' do
      content = "merchant: #{@invoice1.merchant.name}"
      # require 'pry';binding.pry
      visit('/invoices/1')

      expect(page).to have_content(content)
    end
  end

  context 'when visiting /invoices/:id/edit' do

    it 'should display current status ' do
      content = "Current Status: #{@invoice1.status}"

      visit('/invoices/1/edit')

      expect(page).to have_content(content)
    end

    it 'should have a form to accept new status' do
      merchant_id = 12334105
      status = 'pending'

      new_status = 'shipped'
      merchant_id = 12334111
      content = "Current Status: #{@invoice1.status}"

      visit('/invoices/1/edit')

      within('#invoice-edit') do
        fill_in("invoice[status]", with: new_status)
        click_on('Create Invoice')
      end
      expect(Invoice.find(1).status).to eq(new_status)
      expect(Invoice.find(1).merchant_id).to eq(merchant_id)
    end

    it 'should redirect user to /invoices/:id after editing' do

      new_status = 'shipped'

      visit('/invoices/1/edit')

      within('#invoice-edit') do
        fill_in("invoice[status]", with: new_status)
        click_on('Create Invoice')
      end
      expect(current_path).to eq('/invoices/1')
    end
  end

  context 'when a user visits /invoices-dashboard' do
    it 'should dispaly the status percentage' do
      status_percentages = Invoice.group_and_count

      expect(page).to have_content(status_percentages)
    end
  end
end
