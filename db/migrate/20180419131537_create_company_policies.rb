class CreateCompanyPolicies < ActiveRecord::Migration
  def change
    create_table :company_policies do |t|
      t.references :company, index: true, foreign_key: true
      t.boolean :registrations, null: false, default: true  
      t.boolean :payable,       null: false, default: true  
      t.boolean :receivable,    null: false, default: true  
      t.boolean :schedule,      null: false, default: true  
      t.timestamps null: false
    end
  end
end
