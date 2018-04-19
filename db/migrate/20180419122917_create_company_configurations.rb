class CreateCompanyConfigurations < ActiveRecord::Migration
  def change
    create_table :company_configurations do |t|
      t.references :company, index: true, foreign_key: true
      t.boolean :registrations, default: true
      t.boolean :payable, default: true
      t.boolean :receivable, default: true
      t.boolean :schedule, default: true
      t.timestamps null: false
    end
  end
end
