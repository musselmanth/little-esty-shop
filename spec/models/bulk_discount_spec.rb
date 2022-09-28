require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it { should validate_presence_of :threshold }
    it { should validate_presence_of :discount }
    it { should validate_numericality_of(:threshold).with_message("must be a positive whole number") }
    it { should validate_numericality_of(:discount).with_message("must be a number between 1 and 100") }
  end

  describe 'helper methods' do
    it 'convert discount decimal to percentage' do
      discount = create(:bulk_discount, discount: 15)
      expect(discount.discount).to eq(0.15)
      expect(percent_convert(discount.discount)).to eq("15%")
    end
  end

  describe 'instance methods' do
    it 'returns an array of all holidays' do
      bulk_discount_1 = create(:bulk_discount, holiday: "Holiday1")
      bulk_discount_2 = create(:bulk_discount, holiday: "Holiday2")
      bulk_discount_3 = create(:bulk_discount, holiday: "Holiday3")

      expect(BulkDiscount.all_holidays).to match_array(["Holiday1", "Holiday2", "Holiday3"])
    end
  end
end