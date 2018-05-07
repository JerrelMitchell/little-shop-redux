RSpec.describe Invoice do
  describe 'Validations' do
    describe 'validation' do
      it 'should return invalid without a merchant_id' do
        invoice = Invoice.create(status: 'pending')

        expect(invoice).to_not be_valid
      end

      it 'should return invalid without a status' do
        invoice = Invoice.create(merchant_id: 12334112)

        expect(invoice).to_not be_valid
      end
    end
  end

  before(:each) do
    @invoice1 = Invoice.create(merchant_id: 12334111, status: 'pending')
    @invoice2 = Invoice.create(merchant_id: 12334112, status: 'shipped')
    @invoice3 = Invoice.create(merchant_id: 12334113, status: 'returned')
  end

  describe 'Invoices exhibit RUD functionality' do
    describe '.all' do
      it 'should return all invoices' do
        expect(Invoice.all.size).to eq(3)
      end
    end

    describe '.find' do
      it 'should return invoice instance corresponding to id' do
        expect(Invoice.find(1)).to eq(@invoice1)
        expect(Invoice.find(2)).to eq(@invoice2)
      end
    end

    describe '.find_by' do
      it 'should return invoice instance based on passed argument' do
        expect(Invoice.find_by(merchant_id: 12334112)).to eq(@invoice2)
        expect(Invoice.find_by(status: 'returned')).to eq(@invoice3)
      end
    end

    describe '.update' do
      it 'should update the invoice instance and save to database' do
        invoice2 = Invoice.find(2)
        expect(invoice2[:status]).to eq('shipped')

        Invoice.update(2, status: 'returned')
        updated_invoice = Invoice.find(2)

        expect(updated_invoice[:status]).to eq('returned')
      end
    end

    describe '.delete' do
      it 'should update the invoice instance and save to database' do
        invoice3 = Invoice.find(3)
        expect(Invoice.find_by(id: 3)).to eq(invoice3)

        Invoice.delete(3)

        expect(Invoice.find_by(id: 3)).to eq(nil)
      end
    end
  end
end
