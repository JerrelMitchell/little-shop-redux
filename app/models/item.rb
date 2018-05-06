class Item < ActiveRecord::Base
  belongs_to :merchant

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def self.format_price(unit_price)
    (unit_price.to_f / 100)
  end
  
  def self.all_formatted
    items = all
    items.each do |item|
      item.price = format_price(item.price)
    end
    items
  end
end
