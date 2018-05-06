class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def self.format_price(unit_price)
    (unit_price / 100).to_f
  end
end
