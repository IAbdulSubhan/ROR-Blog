class AddOverviewToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :overview, :text
  end
end
