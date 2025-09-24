class AddSuperAdminToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :super_admin, :boolean
  end
end
