class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name, null: false
      t.string :trade_name, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :number, limit: 10
      t.string :neighborhood
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 10, null: false
      t.string :email
      t.string :phone
    end
  end
end
