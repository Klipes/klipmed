class CreateProfessionals < ActiveRecord::Migration
  def change
    create_table :professionals do |t|
      t.string :fullname, null: false
      t.string :email
      t.string :phone, limit: 20, null: false
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
