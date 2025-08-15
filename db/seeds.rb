puts "Limpando o banco de dados..."
Article.destroy_all
User.destroy_all

puts "Criando usuários..."
admin = User.create!(email: 'admin@master.com', password: '123456', role: :admin)
student = User.create!(email: 'aluno@exemplo.com', password: '123456', role: :aluno)

puts "Criando 30 artigos aprovados..."
30.times do
  article = Article.new(
    title: Faker::Book.title,
    status: :aprovado,
    user: student
  )
  # Anexando um arquivo PDF de exemplo
  # Certifique-se de que este arquivo existe no seu projeto!
  # Você pode colocar qualquer PDF pequeno na pasta `public/`.
  article.pdf_file.attach(io: File.open(Rails.root.join('public', 'exemplo.pdf')), filename: 'exemplo.pdf', content_type: 'application/pdf')
  article.save!
end

puts "Feito! Banco de dados populado com sucesso."