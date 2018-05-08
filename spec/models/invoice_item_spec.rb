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
  describe 'invoice items relationships' do

    before(:each) do
      invoice1 = Invoice.create(merchant_id: 12334111, status: 'pending')
      invoice2 = Invoice.create(merchant_id: 12334112, status: 'shipped')
      invoice3 = Invoice.create(merchant_id: 12334113, status: 'returned')
      @first_item_attrs = { id: 1, title: 'The First Cool Item',
                         description: 'It\'s alright',
                         price: 357, image: 'imgs/img1' } 
      @second_item_attrs = { id: 2, title: 'The Second Cool Item',
                           description: 'It\'s cool',
                           price: 1000, image: 'imgs/img2'}
      @third_item_attrs = { id: 3, title: 'The Third Cool Item',
                          description: 'It\'s the coolest',
                          price: 900, image: 'imgs/img3'}
      @item1 = Item.create(@first_item_attrs)
      @item2 = Item.create(@second_item_attrs)
      @item3 = Item.create(@third_item_attrs)

      InvoiceItem.create(item_id: @item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: '714')
      InvoiceItem.create(item_id: @item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: '5000')
    end
    it 'should give invoice acccess to items through item_id' do
      invoice_item = Invoice.find(1).items
      expect(invoice_item).to eq([@item1, @item2])
    end
  end
end