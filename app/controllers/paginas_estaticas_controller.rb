class PaginasEstaticasController < ApplicationController
  def ajuda
  end

  def fale_conosco
  end


  def enviar_contato
  return redirect_to fale_conosco_path, notice: "Sua mensagem foi enviada com sucesso!" if params[:nickname].present?

  nome = params[:nome]
  email = params[:email]
  mensagem = params[:mensagem]

  ContatoMailer.formulario_contato(nome, email, mensagem).deliver_later

  redirect_to fale_conosco_path, notice: "Sua mensagem foi enviada com sucesso! Obrigado pelo contato."
  end
end
