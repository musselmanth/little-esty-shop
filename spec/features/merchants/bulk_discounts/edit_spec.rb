require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page' do
  before :each do
    @bulk_discount = create(:bulk_discount)
    @merchant = @bulk_discount.merchant
  end

  it 'has a title' do
    expect(page).to have_content("Edit Bulk Discount | id: #{@bulk_discount.id}")
  end

  it 'has a form with current values matching the record' do
    
  end
end