class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :company, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.datetime :start
      t.datetime :end
      t.integer :editable,      default: 1

      t.timestamps null: false
    end
  end
end
