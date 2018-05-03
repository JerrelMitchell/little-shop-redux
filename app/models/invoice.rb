class Invoice < ActiveRecord::Base
    validates :merchant_id, presence: true
    validates :status, presence: true
end