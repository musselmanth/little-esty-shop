class InvoiceItem < ApplicationRecord

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.total_revenue
    sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.total_discount
    item_discounts = self
      .joins(:bulk_discounts)
      .select('MAX(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.discount) AS item_discount')
      .where('invoice_items.quantity >= bulk_discounts.threshold')
      .group('items.name, invoice_items.id, items.merchant_id')
    Invoice
      .from(item_discounts, :item_discounts)
      .pluck('SUM(item_discounts.item_discount)').first.to_i
  end

  

  def self.revenue_with_discounts
    total_revenue - total_discount
  end

  def item_name
    item.name
  end

  def invoice_date
    invoice.created_at
  end
end
