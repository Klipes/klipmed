class CreateUserPolicies < ActiveRecord::Migration
  def change
    create_table :user_policies do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :customer,            null: false, default: true 
      t.boolean :supplier,            null: false, default: true  
      t.boolean :covenant,            null: false, default: true  
      t.boolean :payment_method,      null: false, default: true  
      t.boolean :schedule,            null: false, default: true      
      t.boolean :receivable_category, null: false, default: true 
      t.boolean :receivable,          null: false, default: true 
      t.boolean :payable_category,    null: false, default: true 
      t.boolean :payable,             null: false, default: true
      t.timestamps null: false
    end
  end
end
