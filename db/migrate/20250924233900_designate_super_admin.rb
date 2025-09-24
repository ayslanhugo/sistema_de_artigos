# db/migrate/xxxxxxxx_designate_super_admin.rb

class DesignateSuperAdmin < ActiveRecord::Migration[8.0]
  def change
    # Apenas executa esta lógica em ambiente de produção para segurança
    if Rails.env.production?
      # Usa a variável de ambiente para encontrar o email do admin em produção
      admin_email = ENV['ADMIN_EMAIL']

      if admin_email.present?
        # Encontra o utilizador sem causar um erro se ele não existir
        user = User.find_by(email: admin_email)

        # O 'user&.' (safe navigation) é uma forma segura de chamar o update
        # apenas se o 'user' não for nulo.
        if user&.update(super_admin: true)
          puts "INFO: Migração executada. Utilizador #{user.email} foi designado como super admin."
        else
          puts "AVISO: Utilizador com email #{admin_email} não encontrado. Nenhum super admin foi designado."
        end
      else
        puts "AVISO: Variável de ambiente ADMIN_EMAIL não definida. Nenhum super admin foi designado."
      end
    end
  end
end
