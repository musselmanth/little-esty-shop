class Invoice < ApplicationRecord

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :bulk_discounts, through: :invoice_items

  enum status: [:in_progress, :completed, :cancelled]

  def self.incomplete_invoices
    joins(:invoice_items)
      .select('invoices.*')
      .where('invoice_items.status < ?', 2)
      .order(created_at: :asc)
      .distinct
  end

  def total_revenue
    invoice_items.total_revenue
  end

  def total_discount
    invoice_items.total_discount
  end

  def total_revenue_with_discounts
    invoice_items.revenue_with_discounts
  end
end
