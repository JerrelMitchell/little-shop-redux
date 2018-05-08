RSpec.describe InvoiceItem do
  describe 'Validations' do
    it 'should be invalid without item_id' do
      attrs = {invoice_id: 1, quantity: 12, unit_price: '300'}
      invoice_item = InvoiceItem.new(attrs)


      expect(invoice_item).to_not be_valid
    end
    it 'should be invalid without invoice_id' do
      attrs = {item_id: 1, quantity: 12, unit_price: '300'}
      invoice_item = InvoiceItem.new(attrs)

      expect(invoice_item).to_not be_valid
    end
    it 'should be invalid without quantity' do
      attrs = {item_id: 1, invoice_id: 12, unit_price: '300'}
      invoice_item = InvoiceItem.new(attrs)

      expect(invoice_item).to_not be_valid
    end
    it 'should be invalid without unit_price' do
      attrs = {item_id: 1, invoice_id: 12, quantity: 14}
      invoice_item = InvoiceItem.new(attrs)

      expect(invoice_item).to_not be_valid
    end
  end
end