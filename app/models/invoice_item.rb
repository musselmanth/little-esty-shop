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
    Invoice
      .from(discounted_items)
      .sum(:item_discount)
      .to_i
  end

  def self.discounted_items
    joins(:bulk_discounts)
    .select('invoice_items.*, MAX(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.discount) AS item_discount')
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .group('items.name, invoice_items.id, items.merchant_id')
  end

  def self.revenue_with_discounts
    total_revenue - total_discount
  end

  def bulk_discount
    bulk_discounts
      .where('? >= bulk_discounts.threshold', quantity)
      .order(discount: :desc)
      .first
  end

  def item_name
    item.name
  end

  def invoice_date
    invoice.created_at
  end
end
