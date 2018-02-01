class AddNameAndCompanyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_reference :users, :company, index: true, foreign_key: true
  end
end
