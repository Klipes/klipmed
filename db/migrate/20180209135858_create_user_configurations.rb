class CreateUserConfigurations < ActiveRecord::Migration
  def change
    create_table :user_configurations do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :monday_schedule,     null: false, default: true
      t.boolean :tuesday_schedule,    null: false, default: true
      t.boolean :wednesday_schedule,  null: false, default: true
      t.boolean :thursday_schedule,   null: false, default: true
      t.boolean :friday_schedule,     null: false, default: true
      t.boolean :saturday_schedule,   null: false, default: true
      t.boolean :sunday_schedule,     null: false, default: true 
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
