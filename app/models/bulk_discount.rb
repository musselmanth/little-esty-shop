class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  
  before_create :convert_discount_to_decimal
  before_update :convert_discount_to_decimal

  validates :discount, presence: true
  validates :discount, numericality: {
    greater_than_or_equal_to: 1, 
    less_than: 100, 
    only_integer: true,
    message: "must be a number between 1 and 100"
  }
  
  validates :threshold, presence: true
  validates :threshold, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true,
    message: "must be a positive whole number"
  }

  def convert_discount_to_decimal
    self.discount /= 100
  end

  def self.all_holidays
    pluck(:holiday)
  end
end