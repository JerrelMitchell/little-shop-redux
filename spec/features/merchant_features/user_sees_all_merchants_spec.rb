RSpec.describe 'Visitors' do
  it 'should see all merchants in database' do
    merchant_name = 'Ye Newere Shoppe'
    Merchant.create(name: merchant_name)

    visit('/merchants')

    expect(status_code).to eq(200)
    expect(page).to have_content(merchant_name)
  end
end
