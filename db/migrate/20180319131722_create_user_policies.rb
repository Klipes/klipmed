class CreateUserPolicies < ActiveRecord::Migration
  def change
    create_table :user_policies do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :customer,            null: false, default: true 
      t.boolean :supplier,            null: false, default: true  
      t.boolean :schedule,            null: false, default: true      
      t.boolean :receivable,          null: false, default: true 
      t.boolean :payable,             null: false, default: true
      t.time :start_hour          
      t.time :end_hour
      t.timestamps null: false
    end
  end
end
