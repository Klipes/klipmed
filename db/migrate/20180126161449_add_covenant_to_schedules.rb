class AddCovenantToSchedules < ActiveRecord::Migration
  def change
    add_reference :schedules, :covenant, index: true, foreign_key: true
  end
end
