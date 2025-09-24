# app/controllers/paginas_estaticas_controller.rb
class PaginasEstaticasController < ApplicationController
  def ajuda
  end

  def fale_conosco
    # Esta ação apenas mostra o formulário (a view que criamos)
  end

  def enviar_contato
    # Pega os dados do formulário que foram enviados
    nome = params[:nome]
    email = params[:email]
    mensagem = params[:mensagem]

    # Chama o nosso Mailer e o método, passando os dados do formulário
    ContatoMailer.formulario_contato(nome, email, mensagem).deliver_now

    # Redireciona de volta para a página de contato com uma mensagem de sucesso
    redirect_to fale_conosco_path, notice: "Sua mensagem foi enviada com sucesso! Obrigado pelo contato."
  end
end
