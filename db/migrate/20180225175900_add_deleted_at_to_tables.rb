class AddDeletedAtToTables < ActiveRecord::Migration
  def change
    add_column :customers,                 :deleted_at, :datetime
    add_column :suppliers,                 :deleted_at, :datetime
    add_column :receivables,               :deleted_at, :datetime    
    add_column :payables,                  :deleted_at, :datetime    
    add_column :payable_categories,        :deleted_at, :datetime 
    add_column :receivable_categories,     :deleted_at, :datetime 
    add_column :covenants,                 :deleted_at, :datetime  
    add_column :payment_methods,           :deleted_at, :datetime     
    add_column :professional_reservations, :deleted_at, :datetime     
    add_column :schedules,                 :deleted_at, :datetime     
  end
end
