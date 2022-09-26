require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do
  before :each do
    @merchant = create(:merchant)
    @bulk_discount = create(:bulk_discount, merchant: @merchant)
    visit(merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
  end

  it 'lists the bulk discounts threshold and percentage' do
    expect(page).to have_content("Bulk Discount | id: #{@bulk_discount.id}")
    expect(page).to have_content("Item Quantity Threshold: #{@bulk_discount.threshold} items")
    expect(page).to have_content("Discount Percentage: #{percent_convert(@bulk_discount.discount)}")
  end

  it 'has a link to edit the bulk discount' do
    expect(page).to have_link("Edit Bulk Discount")
  end

  it 'edit link goes to the edit page' do
    click_link("Edit Bulk Discount")
    
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
  end
end