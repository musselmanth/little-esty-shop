require 'rails_helper'

RSpec.describe "New Bulk Discount Page" do
  before :each do
    @merchant = create(:merchant)
    visit(new_merchant_bulk_discount_path(@merchant.id))
  end

  it 'has a form to create a new bulk discount' do
    expect(page).to have_content("Item Quantity Threshold: ")
    expect(page).to have_field(:bulk_discount_threshold)
    expect(page).to have_content("Percent Discount: ")
    expect(page).to have_field(:bulk_discount_discount)
  end

  it 'creates a new bulk discount when submitted' do
    fill_in :bulk_discount_threshold, with: "15"
    fill_in :bulk_discount_discount, with: "12"
    click_button("Create Bulk Discount")

    bulk_discount = BulkDiscount.last

    expect(bulk_discount.discount).to eq(0.12)
    expect(bulk_discount.threshold).to eq(15)
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant.id))
    expect(page).to have_content("Bulk Discount successfully created.")
  end

  it 'validates presence of both fields' do
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount can't be blank")
    expect(page).to have_content("Threshold can't be blank")

    fill_in :bulk_discount_threshold, with: "10"
    click_button("Create Bulk Discount")

    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount can't be blank")
    expect(page).to_not have_content("Threshold can't be blank")
    
    visit(new_merchant_bulk_discount_path(@merchant.id))
    fill_in :bulk_discount_discount, with: "20"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to_not have_content("Discount can't be blank")
    expect(page).to have_content("Threshold can't be blank")
  end

  it 'validates numericality of threshold field' do
    fill_in :bulk_discount_discount, with: "20"
    fill_in :bulk_discount_threshold, with: "bob"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Threshold must be a positive whole number")
    
    fill_in :bulk_discount_threshold, with: "-5"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Threshold must be a positive whole number")

    fill_in :bulk_discount_threshold, with: "55.5"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Threshold must be a positive whole number")
  end

  it 'validates numericality of discount percentage' do
    fill_in :bulk_discount_threshold, with: "50"
    fill_in :bulk_discount_discount, with: "0"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount must be a number between 1 and 100")

    fill_in :bulk_discount_discount, with: "15.8"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount must be a number between 1 and 100")

    fill_in :bulk_discount_discount, with: "101"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount must be a number between 1 and 100")

    fill_in :bulk_discount_discount, with: "woeifjwoeifj"
    click_button("Create Bulk Discount")
    
    expect(BulkDiscount.last).to be nil
    expect(page).to have_content("Discount must be a number between 1 and 100")
  end
end