require './db/csv/csv_wizard'
require './app/models/merchant.rb'
require './app/models/invoice.rb'
require './app/models/item.rb'
merchants = CSVWizard.read_file('./data/merchants.csv')
merchants.each do |merchant|
  Merchant.create(id:         merchant[:id],
                  name:       merchant[:name],  
                  created_at: merchant[:created_at],
                  updated_at: merchant[:updated_at])
end

invoices = CSVWizard.read_file('./data/invoices.csv')
invoices.each do |invoice|
  Invoice.create(id:          invoice[:id],
                 merchant_id: invoice[:merchant_id],
                 status:      invoice[:status],
                 created_at:  invoice[:created_at],
                 updated_at:  invoice[:updated_at])
end

items = CSVWizard.read_file('./data/items.csv')
items.each do |item|
  Item.create(id:          item[:id],
              title:       item[:name],
              description: item[:description],
              price:       item[:unit_price],
              merchant_id: item[:merchant_id],
              image:       "/imgs/item-#{item[:id]}")
  
  Merchant.find(item[:merchant_id]).update(item_id: item[:id])
end
