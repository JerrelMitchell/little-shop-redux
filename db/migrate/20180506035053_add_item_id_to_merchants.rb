class AddItemIdToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :item_id, :integer
  end
end
