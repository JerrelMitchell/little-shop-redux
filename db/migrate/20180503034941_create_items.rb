class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |table|
      table.string  :title
      table.text    :description
      table.integer :price
      table.string  :image

      table.timestamps
    end
  end
end
