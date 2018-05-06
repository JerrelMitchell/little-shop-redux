class AddMerchantIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :merchant_id, :integer
  end
end
