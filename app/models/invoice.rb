class Invoice < ApplicationRecord

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :bulk_discounts, through: :invoice_items

  enum status: [:in_progress, :completed, :cancelled]

  def merchant_items(merchant)
    invoice_items
      .joins(:item)
      .select('invoice_items.*, items.name, items.merchant_id')
      .where('items.merchant_id = ?', merchant.id)
  end

  def self.incomplete_invoices
    joins(:invoice_items)
      .select('invoices.*')
      .where('invoice_items.status < ?', 2)
      .order(created_at: :asc)
      .distinct
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_with_discounts(merchant)
    if merchant.bulk_discounts.empty?
      merchant_items(merchant).total_revenue
    else
      total_discounted_revenue(merchant) + total_full_price_revenue(merchant)
    end
  end

  def total_discounted_revenue(merchant)
    ind_items_revenue = invoice_items
      .joins(:bulk_discounts)
      .where('merchants.id = ? AND invoice_items.quantity >= bulk_discounts.threshold', merchant.id)
      .select('MIN(invoice_items.quantity * invoice_items.unit_price * (1 - bulk_discounts.discount)) AS item_revenue')
      .group('invoice_items.id')
    InvoiceItem
      .from(ind_items_revenue, :ind_items_revenue)
      .pluck('SUM(ind_items_revenue.item_revenue)').first.to_i
  end

  def total_full_price_revenue(merchant)
    invoice_items
      .joins(:item)
      .where('items.merchant_id = ? and quantity < ?', merchant.id, merchant.min_bulk_discount_threshold)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
