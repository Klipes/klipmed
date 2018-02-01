class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :supplier_name, null: false
      t.string :trade_name
      t.string :email
      t.string :phone, limit: 20, null: false
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
