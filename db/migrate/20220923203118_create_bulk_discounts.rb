class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :threshold
      t.decimal :discount
      t.timestamps
      t.references :merchant, foreign_key: true
    end
  end
end
