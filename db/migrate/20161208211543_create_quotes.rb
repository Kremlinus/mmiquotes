class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :quote
      t.string :autor
      t.date :date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
