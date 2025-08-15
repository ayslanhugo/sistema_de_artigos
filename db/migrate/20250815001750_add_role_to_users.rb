class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    # Adicionamos a opção default para que todo novo usuário seja um 'aluno'
    add_column :users, :role, :integer, default: 0
  end
end