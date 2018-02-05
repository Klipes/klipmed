class CreateProfessionalReservations < ActiveRecord::Migration
  def change
    create_table :professional_reservations do |t|
      t.references :company, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.string :title

      t.timestamps null: false
    end
  end
end
