class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, primary_key: :id do |table|
      table.integer :id
      table.string  :title
      table.text    :description
      table.integer :price
      table.string  :image

      table.timestamps
    end
  end
end
