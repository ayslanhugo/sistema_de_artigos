# app/mailers/contato_mailer.rb
class ContatoMailer < ApplicationMailer
  # O email do admin será o destinatário padrão
  default to: -> { ENV.fetch("ADMIN_EMAIL", "admin@exemplo.com") }

  def formulario_contato(nome, email_remetente, mensagem)
    @nome = nome
    @email_remetente = email_remetente
    @mensagem = mensagem

    # O email_remetente será usado como o "responder para"
    mail(reply_to: @email_remetente, subject: "Nova Mensagem de Contato do Sistema de Artigos")
  end
end
