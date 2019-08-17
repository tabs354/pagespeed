class ChangeRoleTypeInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admin
    add_column    :users, :role,  :string, null: false, default: "staff"
  end
end
