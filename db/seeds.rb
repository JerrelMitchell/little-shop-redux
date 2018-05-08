require './db/csv/csv_wizard'
require './app/models/merchant.rb'
require './app/models/invoice.rb'
require './app/models/item.rb'
require './app/models/invoice_item.rb'

highest_merchant_id = 0
merchants = CSVWizard.read_file('./data/merchants.csv')
merchants.each do |merchant|
  highest_merchant_id = merchant[:id].to_i if merchant[:id].to_i > highest_merchant_id
  Merchant.create(id: merchant[:id],
                  name:       merchant[:name],
                  created_at: merchant[:created_at],
                  updated_at: merchant[:updated_at])
end
ActiveRecord::Base.connection.execute("ALTER SEQUENCE merchants_id_seq RESTART WITH #{highest_merchant_id}")

highest_invoice_id = 0
invoices = CSVWizard.read_file('./data/invoices.csv')
invoices.each do |invoice|
  highest_invoice_id = invoice[:id].to_i if invoice[:id].to_i > highest_invoice_id
  Invoice.create(id:          invoice[:id],
                 merchant_id: invoice[:merchant_id],
                 status:      invoice[:status],
                 created_at:  invoice[:created_at],
                 updated_at:  invoice[:updated_at])
end
ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoices_id_seq RESTART WITH #{highest_invoice_id}")

highest_item_id = 0
items = CSVWizard.read_file('./data/items.csv')
items.each do |item|
  highest_item_id = item[:id].to_i if item[:id].to_i > highest_item_id
  Item.create(id:          item[:id],
              title:       item[:name],
              description: item[:description],
              price:       item[:unit_price],
              merchant_id: item[:merchant_id],
              image:       "/images/alp-studio-426760-unsplash.png")

  Merchant.find(item[:merchant_id]).update(item_id: item[:id])
end

highest_invoice_item_id = 0
invoice_items = CSVWizard.read_file('./data/invoice_items.csv')
invoice_items.each do |invoice_item|
  highest_invoice_item_id = invoice_item[:id].to_i if invoice_item[:id].to_i > highest_invoice_item_id
  InvoiceItem.create(id:           invoice_item[:id],
                    item_id:       invoice_item[:item_id],
                    invoice_id:    invoice_item[:invoice_id],
                    quantity:      invoice_item[:quantity],
                    unit_price:    invoice_item[:unit_price])
end
ActiveRecord::Base.connection.execute("ALTER SEQUENCE items_id_seq RESTART WITH #{highest_invoice_item_id}")