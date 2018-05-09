RSpec.describe 'Visitors' do
   before(:each) do
      @invoice1 = Invoice.create(merchant_id: 12334111, status: 'pending')
      @invoice2 = Invoice.create(merchant_id: 12334112, status: 'shipped')
      @invoice3 = Invoice.create(merchant_id: 12334113, status: 'returned')
      @merchant1 = Merchant.create(id: 12334111, name: 'Ye Olde Shoppe')
      @merchant2 = Merchant.create(id: 12334112, name: 'Example Shop')
      @item1 = Item.create(id: 2345678, title: 'A shirt', description: 'a really cool shirt', price: '800', image: '/imgs/shirt', merchant_id: 1)
      @item2 = Item.create(id: 1234567, title: 'Shoes', description: 'really cool shoes', price: '400', image: '/imgs/shoes', merchant_id: 1)
      @item3 = Item.create(id: 1234565, title: 'Watch', description: 'really cool shoes', price: '400', image: '/imgs/shoes', merchant_id: 1)
      InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: '1600')
      InvoiceItem.create(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 5, unit_price: '2000')
      InvoiceItem.create(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 5, unit_price: '2000')
      InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 5, unit_price: '4000')
    end

  context 'when visiting /invoices' do
    it 'should see a list of invoices' do
      status1 = 'pending'
      merchant_id1 = 12334135
      status2 = 'shipped'
      merchant_id2 = 12334136
      invoice1 = Invoice.create(merchant_id: merchant_id1, status: status1)
      invoice2 = Invoice.create(merchant_id: merchant_id2, status: status2)

      visit('/invoices')

      expect(status_code).to eq(200)
      expect(page).to have_content(invoice1.id)
      expect(page).to have_content(invoice2.id)
    end
  end

  context 'when visiting /invoices/:id' do
    it 'should display the invoice corresponding to :id' do
      visit('/invoices/1')

      expect(status_code).to eq(200)
      expect(page).to have_content(@invoice1.status)
    end

    it 'should display the merchant name' do
      content = "merchant: #{@invoice1.merchant.name}"
      # require 'pry';binding.pry
      visit('/invoices/1')

      expect(page).to have_content(content)
    end

    it 'should display the item id' do
      visit('/invoices/1')

      expect(page).to have_content(@item1.id)
      expect(page).to have_content(@item2.id)
      expect(page).to have_content(@item3.id)
    end

    it 'should display the item title' do
      visit('/invoices/1')

      expect(page).to have_content(@item1.title)
      expect(page).to have_content(@item2.title)
      expect(page).to have_content(@item3.title)
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
      status_percent = Invoice.status_percentages
      pending = "#{status_percent["pending"]}"
      shipped = "#{status_percent["shipped"]}"
      returned = "#{status_percent["returned"]}"
      visit('/invoices-dashboard')
      expect(page).to have_content(pending)
      expect(page).to have_content(shipped)
      expect(page).to have_content(returned)
    end

    it 'should display the highest and lowest priced invoice' do
      max_invoice_price = Invoice.max_invoice_price
      min_invoice_price = Invoice.min_invoice_price
      visit('/invoices-dashboard')
      expect(page).to have_content(max_invoice_price)
      expect(page).to have_content(min_invoice_price)
    end

    it 'should display the invoices with the largest and smallest quantity of items' do
      max_invoice_quantity = Invoice.max_invoice_quantity
      min_invoice_quantity = Invoice.min_invoice_quantity
      visit('/invoices-dashboard')
      expect(page).to have_content(max_invoice_quantity)
      expect(page).to have_content(min_invoice_quantity)
    end
  end
end
