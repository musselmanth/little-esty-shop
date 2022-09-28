class HolidayFacade
  def self.generate_holidays
    holidays_data = HolidayService.get_three_holidays
    holidays_data.map { |holiday_data| Holiday.new(holiday_data) }
  end
end