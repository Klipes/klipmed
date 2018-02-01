class CreateCovenants < ActiveRecord::Migration
  def change
    create_table :covenants do |t|
      t.references :company, index: true, foreign_key: true
      t.string :description, limit: 50, null:false

      t.timestamps null: false
    end
  end
end
