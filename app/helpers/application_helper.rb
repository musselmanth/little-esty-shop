module ApplicationHelper
  def price_convert(integer_price)
    number_to_currency(integer_price / 100.to_d)
  end

  def percent_convert(decimal_percent)
    "#{(decimal_percent * 100).to_i}%"
  end
end
