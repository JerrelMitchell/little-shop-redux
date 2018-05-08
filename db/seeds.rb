require './db/csv/csv_wizard'
require './app/models/merchant.rb'
require './app/models/invoice.rb'
require './app/models/item.rb'
require './app/models/invoice_item.rb'

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

invoice_items = CSVWizard.read_file('./data/invoice_items.csv')
invoice_items.each do |invoice_item|
  InvoiceItem.create(id:           invoice_item[:id],
                    item_id:       invoice_item[:item_id],
                    invoice_id:    invoice_item[:invoice_id],
                    quantity:      invoice_item[:quantity],
                    unit_price:    invoice_item[:unit_price])
end

