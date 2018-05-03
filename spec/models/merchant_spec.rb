RSpec.describe Merchant do
  describe 'Validations' do
    describe 'validation' do
      it 'is invalid without a name' do
        merchant = Merchant.create(created_at: Time.now)

        expect(merchant).to_not be_valid
      end
    end
  end

  before(:each) do
    @merchant1 = Merchant.create(id: 1, name: 'Ye Olde Shoppe')
    @merchant2 = Merchant.create(id: 2, name: 'Example Shop')
  end

  describe 'Merchants have attributes' do
    describe '.id' do
      it 'should return id of given merchant' do
        expect(Merchant.first.id).to eq(1)
      end
    end

    describe '.name' do
      it 'should return name of given merchant' do
        expect(Merchant.first.name).to eq('Ye Olde Shoppe')
      end
    end
  end

  describe 'Merchants exhibit CRUD functionality' do
    describe '.all' do
      it 'should return all merchants in database' do
        expect(Merchant.all.size).to eq(2)
      end
    end

    describe '.find' do
      it 'should return merchant with given id' do
        expect(Merchant.find(1).name).to eq('Ye Olde Shoppe')
      end
    end

    describe '.update' do
      it 'should update attributes of merchant object with given id' do
        name1 = 'Ye Olde Shoppe'
        name2 = 'Ye Newere Shoppe'
        merchant1 = Merchant.find(1)
        expect(merchant1.name).to eq(name1)

        Merchant.update(1, name: name2)
        merchant2 = Merchant.find(1)

        expect(merchant2.name).to eq(name2)
      end
    end

    describe '.delete' do
      it 'should delete merchant object with given id' do
        merchant = Merchant.find(2)
        Merchant.delete(merchant)

        expect { Merchant.find(2) }.to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Merchant with 'id'=2")
      end
    end
  end
end
