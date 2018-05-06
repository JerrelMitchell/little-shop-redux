RSpec.describe Merchant do
  describe 'Validations' do
    describe 'validation' do
      it 'is invalid without a name' do
        merchant = Merchant.create(created_at: Time.now)

        expect(merchant).to_not be_valid
      end
    end
  end

  describe 'Merchants exhibit CRUD functionality' do
    describe '.all' do
      it 'should return all merchants in database'
      merchant1 = Merchant.create(name: 'Example Shoppe')
      merchant2 = Merchant.create(name: 'Ye Olde Shoppe')
      merchants = [merchant1, merchant2]

      expect(merchants.all.size).to eq(2)
    end

    describe '.find' do
      it 'should get merchant with given id'
      merchant1 = Merchant.create(name: 'Example Shoppe')
      merchant2 = Merchant.create(name: 'Ye Olde Shoppe')
      merchants = [merchant1, merchant2]

      expect(merchants.find(1).name).to eq('Example Shoppe')
    end

    describe '.update' do
      it 'should update merchant object with given id and attributes'
      merchant1 = Merchant.create(name: 'Example Shoppe')
      merchant2 = Merchant.create(name: 'Ye Olde Shoppe')
      merchants = [merchant1, merchant2]

      merchants.update(2, name: 'Ye Newere Shoppe')

      expect(merchants.find(2).name).to eq('Ye Newere Shoppe')
    end

    describe '.delete' do
      it 'should delete merchant object with given id'
      merchant1 = Merchant.create(name: 'Example Shoppe')
      merchant2 = Merchant.create(name: 'Ye Olde Shoppe')
      merchants = [merchant1, merchant2]

      merchants.delete(2)

      expect(merchants.find(2)).to eq(nil)
    end
  end
end
