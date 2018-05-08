class Item < ActiveRecord::Base
  belongs_to :merchant

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :merchant_id, presence: true

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

  def self.new_id
    Item.order("id DESC").limit(1).first.id + 1
  end

  def self.add_item(form_data)
    attrs = {
      id: new_id,
      merchant_id: Merchant.find_by(name: form_data[:merchant]).id,
      title: form_data[:title],
      description: form_data[:description],
      price: (form_data[:price].to_f * 100),
      image: form_data[:image_url]
    }
    create(attrs)
  end

  def self.average_item_price
    average(:price) / 100
  end

  def update_item(form_data)
    attrs = {
      merchant_id: Merchant.find_by(name: form_data[:merchant]).id,
      title: form_data[:title],
      description: form_data[:description],
      price: (form_data[:price].to_f * 100),
      image: form_data[:image_url]
    }
    update(attrs)
  end
end
