class AddHashBodyToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :hashbody, :text
  end
end
