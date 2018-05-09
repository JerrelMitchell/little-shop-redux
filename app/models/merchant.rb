class Merchant < ActiveRecord::Base
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def all_items
    items.count
  end

  def self.average_item_price(merchant)
    all_prices = merchant.items.map(&:price)
    return 0 if all_prices.length.zero?
    (all_prices.sum / all_prices.length)
  end

  def self.total_item_price(merchant)
    all_prices = merchant.items.map(&:price)
    return 0 if all_prices.length.zero?
    all_prices.sum
  end
end
