class Invoice < ActiveRecord::Base
    validates :merchant_id, presence: true
    validates :status, presence: true
    belongs_to :merchant
    has_many(:invoice_items)
    has_many(:items, through: :invoice_items)

    def self.group_and_count
        grouped_by_status = Invoice.all.group(:status).count
        total = grouped_by_status.values.inject { |a, b| a + b }
        new_hash = {}
        grouped_by_status.each do |key, value|
            new_hash[key] = (((value.to_f * 100) / (total.to_f * 100)) * 100).to_i
        end
        return new_hash 
        #returns hash: {"returned"=>33, "pending"=>33, "shipped"=>33}
    end

    def self.invoice_total
        hash = Hash[
            InvoiceItem.select("invoice_id, SUM(coalesce(unit_price, 0)) as invoice_price").group(:invoice_id).order("invoice_price DESC").map do |row| 
            [row.invoice_id, row.invoice_price]
            end
            ]
        return hash
    end
    def self.min_invoice
        Invoice.invoice_total.keys.last #returns the min invoice_id
    end

    def self.max_invoice
        Invoice.invoice_total.keys.first #returns the max invoice_id
    end
end