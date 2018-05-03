RSpec.describe 'Visitors' do
  it 'should see updated merchant in list after updating merchant' do
    merchant_name = 'Ye Olde Shoppe'
    Merchant.create(id: 1, name: merchant_name)

    visit('/merchants/1/edit')

    expect(status_code).to eq(200)
    expect(page).to have_content(merchant_name)
  end
end
