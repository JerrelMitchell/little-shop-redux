require './db/csv/csv_wizard'
require './app/models/merchant.rb'
merchants = CSVWizard.read_file('./data/merchants.csv')
merchants.each do |merchant|
  Merchant.create(id:         merchant[:id],
                  name:       merchant[:name],
                  created_at: merchant[:created_at],
                  updated_at: merchant[:updated_at])
end
