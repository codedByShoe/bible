class CreateVerses < ActiveRecord::Migration[8.0]
  def change
    create_table :verses do |t|
      t.references :chapter, null: false, foreign_key: true
      t.integer :number, null: false
      t.text :text, null: false

      t.timestamps
    end
    
    add_index :verses, [:chapter_id, :number], unique: true
  end
end
