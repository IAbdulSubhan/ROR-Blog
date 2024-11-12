class AddStripeFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :subscription_status, :string
  end
end
