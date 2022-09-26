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
end