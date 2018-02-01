class CreateProfessionalCovenants < ActiveRecord::Migration
  def change
    create_table :professional_covenants do |t|
      t.references :professional, index: true, foreign_key: true
      t.references :covenant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
