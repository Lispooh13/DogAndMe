class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :dog_type, null: false
      t.integer :dog_size, null: false, default: 0

      t.timestamps
    end
  end
end
