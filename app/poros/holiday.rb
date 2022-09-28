class Holiday
  attr_reader :name, :date

  def initialize(data)
    @name = data[:name]
    @date = data[:date].to_datetime
  end

  def has_discount?(merchant_id)
    BulkDiscount.all_holidays.include?([@name, merchant_id])
  end

  def discount_id(merchant_id)
    bulk_discount = BulkDiscount.find_by(holiday: @name, merchant_id: merchant_id)
    bulk_discount.id
  end
end