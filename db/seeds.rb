# db/seeds.rb

puts "A iniciar o processo de seed para o ambiente: #{Rails.env}"

if Rails.env.development?
  puts "Carregando dados de DESENVOLVIMENTO..."
  load(Rails.root.join('db', 'seeds', 'development.rb'))
elsif Rails.env.production?
  puts "Carregando dados de PRODUÇÃO..."
  load(Rails.root.join('db', 'seeds', 'production.rb'))
end

puts "Processo de seed finalizado para o ambiente: #{Rails.env}"
