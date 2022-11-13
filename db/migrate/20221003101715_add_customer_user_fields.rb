class AddCustomerUserFields < ActiveRecord::Migration[6.1]
  def change
    add_column :customer_users, :first_name, :string, null: false
    add_column :customer_users, :last_name, :string, null: false
    add_column :customer_users, :mobile_phone, :string, null: false
  end
end
