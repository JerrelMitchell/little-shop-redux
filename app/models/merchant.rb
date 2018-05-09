class Merchant < ActiveRecord::Base
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.average_price
    items.average(:price).to_f
  end

  require 'pry' ; binding.pry
  def self.total_item_count
    sum(items)
  end
end
