class AddCatagoryToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :catagory, null: false, foreign_key: true
  end
end
