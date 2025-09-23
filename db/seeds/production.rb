# db/seeds/production.rb

puts "Executando seed de Produção: Apenas o Admin será criado."

# Pega as credenciais das variáveis de ambiente de forma segura
admin_email = ENV['ADMIN_EMAIL']
admin_password = ENV['ADMIN_PASSWORD']

# Verifica se as variáveis foram configuradas no ambiente de produção
if admin_email.blank? || admin_password.blank?
  puts "AVISO: As variáveis de ambiente ADMIN_EMAIL ou ADMIN_PASSWORD não estão definidas em produção."
  puts "O utilizador Admin não será criado. Por favor, configure-as na sua plataforma de hospedagem."
else
  # Usa find_or_create_by para não criar duplicados
  User.find_or_create_by!(email: admin_email) do |user|
    user.password = admin_password
    user.password_confirmation = admin_password
    user.role = :admin # Ajuste 'role' e ':admin' conforme o seu modelo
    puts "Utilizador Admin '#{admin_email}' criado com sucesso!"
  end
end

puts "Seed de Produção concluído."
