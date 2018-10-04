class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :user_id
      t.integer :item_id
      t.string :title
      t.integer :rating

      t.timestamps
    end
  end
end
