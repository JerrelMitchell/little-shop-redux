class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
     create_table :invoices do |t|
      t.integer :merchant_id, null: false
      t.string  :status

      t.timestamps
     end
  end
end
