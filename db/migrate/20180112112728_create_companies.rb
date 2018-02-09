class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name, null: false
      t.string :trade_name, null: false
      t.string :email
      t.string :phone
    end
  end
end
