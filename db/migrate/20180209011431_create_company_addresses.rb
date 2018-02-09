class CreateCompanyAddresses < ActiveRecord::Migration
  def change
    create_table :company_addresses do |t|
      t.string :address1, null: false
      t.string :address2
      t.string :number, limit: 10
      t.string :neighborhood
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 10, null: false
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
