RSpec.describe 'Visitors' do
  it 'should be able to visit page to create new merchant' do
    message = 'Create New Merchant'
    visit('/merchants/new')

    expect(status_code).to eq(200)
    expect(page).to have_content(message)
  end
end
