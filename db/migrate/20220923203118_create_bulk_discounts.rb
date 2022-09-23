class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :threshhold
      t.decimal :discount
      t.references :merchants, foreign_key: true
    end
  end
end
