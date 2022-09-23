require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'helper methods' do
    it 'convert discount decimal to percentage' do
      discount = create(:bulk_discount, discount: 0.15)
      expect(discount.discount).to eq(0.15)
      expect(percent_convert(discount.discount)).to eq("15%")
    end
  end
end