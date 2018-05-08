class Merchant < ActiveRecord::Base
  validates_presence_of :name
  has_many :items
end
