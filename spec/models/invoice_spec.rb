RSpec.describe Invoice do
  describe 'Validations' do
    describe 'validation' do
      it 'should return invalid without a merchant_id' do
        invoice = Invoice.create(status: "pending")

        expect(invoice).to_not be_valid
      end

      it 'should return invalid without a status' do
        invoice = Invoice.create(merchant_id: 12334112)

        expect(invoice).to_not be_valid
      end
    end
  end

  describe 'Invoices exhibit RUD functionality' do
    describe '.all' do
      it 'should return all invoices' do
        invoice_1 = Invoice.create(merchant_id: 12334111, status: "pending")
        invoice_2 = Invoice.create(merchant_id: 12334112, status: "shipped")
        invoice_3 = Invoice.create(merchant_id: 12334113, status: "shipped")

        expect(Invoice.all.length).to eq(3)
      end
    end

    describe '.find' do
      it 'should return invoice instance corresponding to id' do
        invoice_1 = Invoice.create(merchant_id: 12334111, status: "pending")
        invoice_2 = Invoice.create(merchant_id: 12334112, status: "shipped")
        invoice_3 = Invoice.create(merchant_id: 12334113, status: "shipped")

        expect(Invoice.find(1)).to eq(invoice_1)
      end
    end

    describe '.find_by' do
      it 'should return invoice instance based on passed argument' do
        invoice_1 = Invoice.create(merchant_id: 12334111, status: "pending")
        invoice_2 = Invoice.create(merchant_id: 12334112, status: "shipped")
        invoice_3 = Invoice.create(merchant_id: 12334113, status: "returned")

        expect(Invoice.find_by(merchant_id: 12334112)).to eq(invoice_2)
        expect(Invoice.find_by(status: "returned")).to eq(invoice_3)
      end
    end

    describe '.update' do
      it 'should update the invoice instance and save to database' do
        Invoice.create(merchant_id: 12334111, status: "pending")
        Invoice.create(merchant_id: 12334112, status: "shipped")
        Invoice.create(merchant_id: 12334113, status: "shipped")
        invoice_3 = Invoice.find(3)

        expect(invoice_3[:status]).to eq("shipped")

        updated_invoice = Invoice.update(3, status: "returned")

        expect(updated_invoice[:status]).to eq("returned")
      end
    end

    describe '.delete' do
      it 'should update the invoice instance and save to database' do
        Invoice.create(merchant_id: 12334111, status: "pending")
        Invoice.create(merchant_id: 12334112, status: "shipped")
        Invoice.create(merchant_id: 12334113, status: "shipped")
        invoice_3 = Invoice.find(3)

        expect(Invoice.find(3)).to eq(invoice_3)

        Invoice.delete(3)

        expect(Invoice.find_by(id: 3)).to eq(nil)
      end
    end
  end

end