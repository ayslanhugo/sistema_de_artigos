# app/controllers/admin/users_controller.rb

class Admin::UsersController < ApplicationController
  # Garante que apenas admins acedam a QUALQUER ação deste controller
  before_action :require_admin

  def index
    # Usamos .not(id: current_user.id) para não listar o admin atual,
    # evitando que ele se rebaixe acidentalmente na view.
    users_query = User.order(:email).where.not(id: current_user.id)
    @pagy, @users = pagy(users_query, items: 20)
  end

# app/controllers/admin/users_controller.rb
# app/controllers/admin/users_controller.rb

def update
  @user = User.find(params[:id])

  # Verificação 1: Ninguém pode alterar o super admin. (Já implementado por si)
  if @user.super_admin?
    redirect_to admin_users_path, alert: "O super administrador não pode ser alterado."
    return
  end

  # Verificação 2: Um admin não pode alterar o seu próprio papel. (Adicionar esta verificação)
  if @user == current_user
    redirect_to admin_users_path, alert: "Você não pode alterar o seu próprio papel de administrador."
    return
  end

  # Se passar nas duas verificações, a lógica de alterar o papel continua...
  if @user.aluno?
    @user.admin! # Promove para admin
    notice_message = "#{@user.email} foi promovido a administrador."
  else
    @user.aluno! # Rebaixa para aluno
    notice_message = "#{@user.email} foi rebaixado para aluno."
  end

  redirect_to admin_users_path, notice: notice_message
end
end
