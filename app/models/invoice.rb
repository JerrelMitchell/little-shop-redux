class Invoice < ActiveRecord::Base
  validates :merchant_id, presence: true
  validates :status, presence: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
