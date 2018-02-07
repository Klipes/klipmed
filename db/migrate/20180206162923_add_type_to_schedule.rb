class AddTypeToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :schedule_type, :integer, default: 1
  end
end
