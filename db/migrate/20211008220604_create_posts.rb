class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :place, null: false
      t.string :address, null: false
      t.integer :purpose, null: false, default: 0
      t.float :latitude
      t.float :longitude
      t.text :body, null: false

      t.timestamps
    end
  end
end
