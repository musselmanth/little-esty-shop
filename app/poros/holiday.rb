class Holiday
  attr_reader :name, :date

  def initialize(data)
    @name = data[:name]
    @date = data[:date].to_datetime
  end

  def has_discount?
    BulkDiscount.all_holidays.include?(@name)
  end

  def discount_id
    bulk_discount = BulkDiscount.find_by(holiday: @name)
    bulk_discount.id
  end
end