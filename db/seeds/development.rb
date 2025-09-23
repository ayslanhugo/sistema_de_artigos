# db/seeds/development.rb

puts "Executando seed de Desenvolvimento: Limpando e populando o banco de dados..."

puts "Limpando o banco de dados..."
Article.destroy_all
User.destroy_all

puts "Criando usuários..."
# Podemos usar find_or_create_by aqui também para consistência
admin = User.find_or_create_by!(email: 'admin@master.com') do |user|
  user.password = '123456'
  user.role = :admin
end

student = User.find_or_create_by!(email: 'aluno@exemplo.com') do |user|
  user.password = '123456'
  user.role = :aluno
end


puts "Criando 30 artigos de teste aprovados..."
30.times do
  article = Article.new(
    title: Faker::Book.title,
    status: :aprovado,
    user: student
  )
  # Anexando um arquivo PDF de exemplo - Descomente se precisar
  # if File.exist?(Rails.root.join('public', 'exemplo.pdf'))
  #   article.pdf_file.attach(io: File.open(Rails.root.join('public', 'exemplo.pdf')), filename: 'exemplo.pdf', content_type: 'application/pdf')
  # end
  article.save!
end

puts "Feito! Banco de dados de desenvolvimento populado com sucesso."
