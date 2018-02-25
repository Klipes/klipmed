class CreateReceivables < ActiveRecord::Migration
  def change
    create_table :receivables do |t|
      t.references :company, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.references :receivable_category, index: true, foreign_key: true
      t.date :due_date
      t.integer :amount_cents
      t.string :description, limit: 50, null: false
      t.string :installment, limit: 5, null: false
      t.integer :status, null: false, default: 0
    end
  end
end
