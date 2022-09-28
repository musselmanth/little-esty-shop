require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index Page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(:bulk_discount, merchant: @merchant, threshold: 10, discount: 5)
    @discount_2 = create(:bulk_discount, merchant: @merchant, threshold: 15, discount: 10)
    @discount_3 = create(:bulk_discount, merchant: @merchant, threshold: 20, discount: 15)
    visit(merchant_bulk_discounts_path(@merchant.id))
  end

  it 'lists each discount and threshold' do
    within("div#discount_#{@discount_1.id}") do
      expect(page).to have_content("Bulk Discount 1")
      expect(page).to have_content("Item Quantity Threshold: #{@discount_1.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_1.discount)}")
    end
    within("div#discount_#{@discount_2.id}") do
      expect(page).to have_content("Bulk Discount 2")
      expect(page).to have_content("Item Quantity Threshold: #{@discount_2.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_2.discount)}")
    end
    within("div#discount_#{@discount_3.id}") do
      expect(page).to have_content("Bulk Discount 3")
      expect(page).to have_content("Item Quantity Threshold: #{@discount_3.threshold} items")
      expect(page).to have_content("Discount Percentage: #{percent_convert(@discount_3.discount)}")
    end
  end

  it 'has a link to each bulk discount show page' do
    within("div#discount_#{@discount_1.id}") do
      expect(page).to have_link("Bulk Discount 1")
      
      click_link("Bulk Discount 1")
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant.id, @discount_1.id))
    end
  end

  it 'has a link to create a new bulk discount' do
    expect(page).to have_link("New Bulk Discount")
    click_link("New Bulk Discount")
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant.id))
  end

  it 'has a link to delete the bulk discount' do
    within("div#discount_#{@discount_1.id}") do
      expect(page).to have_link("Delete")
    end
  end

  it 'destroys the bulk discount upon clicking' do
    within("div#discount_#{@discount_1.id}") do
      click_link("Delete")
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant.id))
    expect(page).to_not have_css("div#discount_#{@discount_1.id}")
    expect(BulkDiscount.exists?(id: @discount_1.id)).to be false
  end

  it 'lists 3 upcoming holidays' do
    expect(page).to have_content("Upcoming US Holidays")
    expect(page).to have_content("Christmas Day")
    expect(page).to have_content("December 25, 2022")
    expect(page).to have_content("New Years Eve")
    expect(page).to have_content("December 31, 2022")
    expect(page).to have_content("New Years Day")
    expect(page).to have_content("January 1, 2023")
  end
end