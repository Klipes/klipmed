class AddPhoneAndNameToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :new_customer_phone, :string, limit: 20
    add_column :schedules, :new_customer_name,  :string
    add_column :schedules, :released,           :string, limit: 1, default: "N" 
  end
end
