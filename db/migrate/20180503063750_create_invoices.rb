class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
     create_table :invoices, id: false do |t|
      t.integer :id
      t.integer :merchant_id
      t.string  :status

      t.timestamps
     end
  end
end
