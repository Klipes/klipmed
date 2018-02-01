class CreatePayableCategories < ActiveRecord::Migration
  def change
    create_table :payable_categories do |t|
      t.text :description, limit: 50, null:false
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
