class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :place
      t.string :address
      t.integer :purpose
      t.float :latitude
      t.float :longitude
      t.text :body

      t.timestamps
    end
  end
end
