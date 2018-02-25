class AddIdentifierToTables < ActiveRecord::Migration
  def change
    add_column :companies, :company_type, :integer
    add_column :companies, :identifier, :string, limit: 20  
  end
end