require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page' do
  before :each do
    @bulk_discount = create(:bulk_discount, threshold: 10, discount: 5)
    @merchant = @bulk_discount.merchant

    visit(edit_merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
  end

  it 'has a title' do
    expect(page).to have_content("Edit Bulk Discount | id: #{@bulk_discount.id}")
  end

  it 'has a form with current values matching the record' do
    expect(page).to have_content("Item Quantity Threshold: ")
    expect(page).to have_field(:bulk_discount_threshold, with: @bulk_discount.threshold)
    expect(page).to have_content("Percent Discount: ")
    expect(page).to have_field(:bulk_discount_discount, with: (@bulk_discount.discount * 100).to_i)
  end

  it 'updates the bulk discount once submitted' do
    fill_in :bulk_discount_threshold, with: "18"
    fill_in :bulk_discount_discount, with: "22"
    click_button("Update Bulk Discount")

    expect(@bulk_discount.reload.discount).to eq(0.22)
    expect(@bulk_discount.reload.threshold).to eq(18)
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
  end

  it 'has sad path' do
    fill_in :bulk_discount_threshold, with: "infinity"
    fill_in :bulk_discount_discount, with: "22"
    click_button("Update Bulk Discount")

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
    expect(page).to have_content("Threshold must be a positive whole number")
    expect(@bulk_discount.reload.threshold).to eq(10)
  end
end