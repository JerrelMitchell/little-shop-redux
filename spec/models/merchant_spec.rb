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
      it 'should return all merchants in database' do
        Merchant.create(id: 1, name: 'Example Shoppe')
        Merchant.create(id: 2, name: 'Ye Olde Shoppe')

        expect(Merchant.all.size).to eq(2)
      end
    end

    describe '.find' do
      it 'should return merchant with given id' do
        Merchant.create(id: 1, name: 'Example Shoppe')
        Merchant.create(id: 2, name: 'Ye Olde Shoppe')

        expect(Merchant.find_by(name: 'Example Shoppe').name).to eq('Example Shoppe')
      end
    end

    # describe '.update' do
    #   it 'should update attributes of merchant object with given id' do
    #     Merchant.create(id: 1, name: 'Example Shoppe')
    #     Merchant.create(id: 2, name: 'Ye Olde Shoppe')
    #
    #     Merchant.update(2, name: 'Ye Newere Shoppe')
    #     Merchant.save
    #
    #     expect(Merchant.find_by(name: 'Ye Newere Shoppe').name).to eq('Ye Newere Shoppe')
    #   end
    # end
    #
    # describe '.delete' do
    #   it 'should delete merchant object with given id' do
    #     Merchant.create(id: 1, name: 'Example Shoppe')
    #     Merchant.create(id: 2, name: 'Ye Olde Shoppe')
    #
    #     Merchant.delete(2)
    #
    #     expect(Merchant.find(2)).to eq(nil)
    #   end
    # end
  end
end
