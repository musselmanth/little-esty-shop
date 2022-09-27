require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:transactions)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'status enum' do
    it 'should respond to enum methods' do
      customer = Customer.create!(first_name: "Gunther", last_name: "Guyman")
      invoice = Invoice.create!(customer_id: customer.id, status: 0)

      expect(invoice.in_progress?).to be(true)
      expect(invoice.status).to eq("in_progress")

      invoice.completed!
      expect(invoice.in_progress?).to be(false)
    end
  end

  describe 'class methods' do
    before(:each) do
      @merchant = create(:merchant)

      @customer1 = Customer.create!(first_name: 'Gunther', last_name: 'Guyman')
      @customer2 = Customer.create!(first_name: 'Miles', last_name: 'Prower')
      @customer3 = Customer.create!(first_name: 'Mario', last_name: 'Mario')
      @customer4 = Customer.create!(first_name: 'Marneus', last_name: 'Calgar')
      @customer5 = Customer.create!(first_name: 'Sol', last_name: 'Badguy')
      @customer6 = Customer.create!(first_name: 'Wyatt', last_name: 'Kribs')

      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2)
      @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: 10.seconds.ago)
      @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: 100.seconds.ago)
      @invoice4 = Invoice.create!(customer_id: @customer1.id, status: 2)
      @invoice5 = Invoice.create!(customer_id: @customer1.id, status: 2)
      @invoice6 = Invoice.create!(customer_id: @customer2.id, status: 2)
      @invoice7 = Invoice.create!(customer_id: @customer2.id, status: 2)
      @invoice8 = Invoice.create!(customer_id: @customer2.id, status: 2)
      @invoice9 = Invoice.create!(customer_id: @customer2.id, status: 2)
      @invoice10 = Invoice.create!(customer_id: @customer3.id, status: 2)
      @invoice11 = Invoice.create!(customer_id: @customer3.id, status: 2)
      @invoice12 = Invoice.create!(customer_id: @customer3.id, status: 2)
      @invoice13 = Invoice.create!(customer_id: @customer4.id, status: 2)
      @invoice14 = Invoice.create!(customer_id: @customer4.id, status: 2)
      @invoice15 = Invoice.create!(customer_id: @customer5.id, status: 2)

      @item1 = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)
      @item3 = create(:item, merchant: @merchant)

      @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 5, status: 2)
      @inv_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 5, status: 0)
      @inv_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: 5, status: 0)


      @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: 12345, result: 1)
      @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: 12345, result: 1)
      @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: 12345, result: 1)
      @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: 12345, result: 1)
      @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: 12345, result: 1)
      @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: 12345, result: 1)
      @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: 12345, result: 1)
      @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: 12345, result: 1)
      @transaction9 = Transaction.create!(invoice_id: @invoice9.id, credit_card_number: 12345, result: 1)
      @transaction10 = Transaction.create!(invoice_id: @invoice10.id, credit_card_number: 12345, result: 1)
      @transaction11 = Transaction.create!(invoice_id: @invoice11.id, credit_card_number: 12345, result: 1)
      @transaction12 = Transaction.create!(invoice_id: @invoice12.id, credit_card_number: 12345, result: 1)
      @transaction13 = Transaction.create!(invoice_id: @invoice13.id, credit_card_number: 12345, result: 1)
      @transaction14 = Transaction.create!(invoice_id: @invoice14.id, credit_card_number: 12345, result: 1)
      @transaction15 = Transaction.create!(invoice_id: @invoice15.id, credit_card_number: 12345, result: 1)
    end

    describe 'self.incomplete_invoices' do
      it 'returns invoices with unshipped items ordered by the oldest created' do
        expect(Invoice.all.incomplete_invoices).to eq([@invoice3, @invoice2])
      end
    end
  end

  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)
      @bulk_discount_1 = create(:bulk_discount, threshold: 6, discount: 10, merchant: @merchant)
      @bulk_discount_2 = create(:bulk_discount, threshold: 10, discount: 15, merchant: @merchant)
      @items = create_list(:item, 5, merchant: @merchant)
      @invoice = create(:invoice)
      @invoice_item_1 = create(:invoice_item, item: @items[0], quantity: 15, unit_price: 15000, invoice: @invoice)
      @invoice_item_3 = create(:invoice_item, item: @items[2], quantity: 7, unit_price: 1375, invoice: @invoice)
      @invoice_item_5 = create(:invoice_item, item: @items[4], quantity: 5, unit_price: 2500, invoice: @invoice)
    end

    describe '.total_revenue' do
      it "returns the total_revenue for an invoice" do
        expect(@invoice.total_revenue).to eq(247125)
      end
    end

    describe '.total_discount' do
      it 'returns the total discount for the invoice' do
        expect(@invoice.total_discount).to eq(34712)
      end
    end

    describe '.revenue_with_discounts' do
      it 'returns the total revenue for the invoice with discounts subtracted' do
        expect(@invoice.total_revenue_with_discounts).to eq(212413)
      end
    end
  end
end
