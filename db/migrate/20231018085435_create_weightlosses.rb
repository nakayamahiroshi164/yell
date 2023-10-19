class CreateWeightlosses < ActiveRecord::Migration[7.0]
  def change
    create_table :weightlosses do |t|
      t.integer :weight    
      t.integer :sleep, null: false
      t.integer :faigue, null: false
      t.text :exercise
      t.text :meal
      t.timestamps
    end
  end
end
