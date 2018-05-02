RSpec.describe Merchant do
  describe 'Merchants exhibit CRUD functionality'
  describe '.all' do
    it 'should return all merchants in database'
    Merchant.create(name: 'Example Shoppe')

    expect(Merchant.all).to eq('Example Shoppe')
  end

  describe '.find' do
    it 'should get merchant object with given id'

    expect(Merchant.find(12_334_135).name).to eq('GoldenRayPress')
  end

  describe '.update' do
    it 'should update merchant object with given id and attributes'

    expect(Merchant.update())
  end
end
