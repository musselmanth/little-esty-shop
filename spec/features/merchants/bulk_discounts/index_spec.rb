require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index Page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(:bulk_discount, merchant: @merchant, threshold: 10, discount: 0.05)
    @discount_2 = create(:bulk_discount, merchant: @merchant, threshold: 15, discount: 0.10)
    @discount_3 = create(:bulk_discount, merchant: @merchant, threshold: 20, discount: 0.15)
    visit(merchant_bulk_discounts_path(@merchant.id))
  end

  it 'lists each discount and threshold' do
    within("div#discount_#{@discount_1.id}") do
      expect(page).to have_content("Bulk Discount ##{@discount_1.id}")
      expect(page).to have_content("Threshold: #{@discount_1.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_1.discount)}")
    end
    within("div#discount_#{@discount_2.id}") do
      expect(page).to have_content("Bulk Discount ##{@discount_2.id}")
      expect(page).to have_content("Threshold: #{@discount_2.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_2.discount)}")
    end
    within("div#discount_#{@discount_3.id}") do
      expect(page).to have_content("Bulk Discount ##{@discount_3.id}")
      expect(page).to have_content("Threshold: #{@discount_3.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_3.discount)}")
    end
  end

  it 'has a link to each bulk discount show page' do
    within("div#discount_#{@discount_1.id}") do
      expect(page).to have_link("Bulk Discount ##{@discount_1.id}")
      
      click_link("Bulk Discount ##{@discount_1.id}")
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant.id, @discount_1.id))
    end
  end
end