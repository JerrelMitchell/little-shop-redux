class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.integer :item_id
      t.float :unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
