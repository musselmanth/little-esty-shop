require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '.price_convert' do
    it 'converts an integer price to a dollar value' do
      expect(price_convert(1500)).to eq("$15.00")
      expect(price_convert(1500075)).to eq("$15,000.75")
      expect(price_convert(123456789)).to eq("$1,234,567.89")
    end
  end
  
  describe '.percent_convert' do
    it 'converts a decimal to percentage for views' do
      expect(percent_convert(1.0)).to eq("100%")
      expect(percent_convert(0.15)).to eq("15%")
      expect(percent_convert(0.5654)).to eq("56%")
    end
  end
end