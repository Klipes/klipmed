class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.references :company, index: true, foreign_key: true
      t.string :description, limit: 20

      t.timestamps null: false
    end
  end
end
