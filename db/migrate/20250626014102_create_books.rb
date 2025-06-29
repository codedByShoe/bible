class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.integer :order_number, null: false

      t.timestamps
    end
    
    add_index :books, :order_number, unique: true
    add_index :books, :name
  end
end
