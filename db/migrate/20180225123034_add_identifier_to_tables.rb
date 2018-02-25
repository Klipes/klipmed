class AddIdentifierToTables < ActiveRecord::Migration
  def change
    add_column :companies, :company_type, :integer
    add_column :companies, :identifier, :string, limit: 20  

    add_column :customers, :identifier, :string, limit: 20
  
    add_column :suppliers, :supplier_type, :integer
    add_column :suppliers, :identifier, :string, limit: 20  
  end
end