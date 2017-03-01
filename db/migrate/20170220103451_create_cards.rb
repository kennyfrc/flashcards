class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.date :review_date
      t.integer :user_id

      t.timestamps
    end
  end
end
