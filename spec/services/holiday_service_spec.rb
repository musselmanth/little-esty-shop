require 'rails_helper'

RSpec.describe HolidayService do
  it 'returns data from API' do
    response = HolidayService.get_uri('https://date.nager.at/api/v3/NextPublicHolidays/US')
    expect(response).to be_a Array
  end

  it 'returns some US holidays' do
    response = HolidayService.get_three_holidays
    expect(response[0][:date]).to be_a String
    expect(response[0][:name]).to be_a String
  end
end