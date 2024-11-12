class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :post, null: false, foreign_key: true
      t.integer :parent_id, index: true


      t.timestamps
    end
  end
end
