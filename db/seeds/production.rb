# db/seeds/production.rb

puts "Executando seed de Produção: Apenas o Admin será criado."

admin_email = ENV['ADMIN_EMAIL']
admin_password = ENV['ADMIN_PASSWORD']

if admin_email.blank? || admin_password.blank?
  puts "AVISO: As variáveis de ambiente ADMIN_EMAIL ou ADMIN_PASSWORD não estão definidas em produção."
  puts "O utilizador Admin não será criado. Por favor, configure-as na sua plataforma de hospedagem."
else

  User.find_or_create_by!(email: admin_email) do |user|
    user.password = admin_password
    user.password_confirmation = admin_password
    user.role = :admin
    puts "Utilizador Admin '#{admin_email}' criado com sucesso!"
  end
end

puts "Seed de Produção concluído."
