class CreateUserCovenants < ActiveRecord::Migration
  def change
    create_table :user_covenants do |t|
      t.references :user, index: true, foreign_key: true
      t.references :covenant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
