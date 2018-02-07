class AddPhoneAndNameToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :new_customer_phone, :string, limit: 20
    add_column :schedules, :new_customer_name, :string
  end
end
