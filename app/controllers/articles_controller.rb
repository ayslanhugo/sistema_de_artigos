class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy approve reject set_pending view_pdf ]
  before_action :authorize_student!, only: %i[ edit update destroy ]
  before_action :require_admin, only: %i[ approve reject set_pending ]
  before_action :authorize_viewer!, only: :view_pdf

    def index
    # 1. Garante que apenas admins podem aceder a esta lista completa.
    require_admin

    # 2. Resolve o problema N+1 carregando previamente os dados necessários.
    @articles = Article.all.includes(:user).with_attached_cover_image
    end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.status = :pendente

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: t("articles.create.notice") }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t("articles.update.notice") }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy!
    respond_to do |format|
      format.html { redirect_to meus_artigos_path, notice: t("articles.destroy.notice") }
      format.json { head :no_content }
    end
  end

  def approve
    @article.aprovado!
    redirect_back fallback_location: gerenciar_artigos_path, notice: t("articles.approve.notice")
  end

 def reject
    reason = params[:rejection_reason]

    if @article.update(status: :reprovado, rejection_reason: reason, rejection_seen: false)
      redirect_back fallback_location: gerenciar_artigos_path, notice: t("articles.reject.notice")
    else
      redirect_back fallback_location: gerenciar_artigos_path, alert: "Não foi possível reprovar o artigo. O motivo é obrigatório."
    end
end

  def set_pending
    @article.pendente!
    redirect_back fallback_location: gerenciar_artigos_path, notice: t("articles.set_pending.notice")
  end

  def view_pdf
    send_data @article.pdf_file.download,
              filename: @article.pdf_file.filename.to_s,
              type: @article.pdf_file.content_type,
              disposition: "inline"
  end

  private
  def authorize_viewer!
    # Se o artigo estiver aprovado, todos podem ver.
    return if @article.aprovado?

    # Se ninguém estiver logado, bloqueia o acesso a artigos não aprovados.
    authenticate_user!

    # O admin ou o dono do artigo podem ver.
    return if current_user.admin? || @article.user == current_user

    # Se nenhuma das condições acima for satisfeita, o acesso é negado.
    redirect_to root_path, alert: "Você não tem permissão para ver este ficheiro."
  end

  def set_article
    @article = Article.find(params[:id])
  end

    def article_params
      params.require(:article).permit(:title, :pdf_file, :cover_image)
    end

    def authorize_student!
      return if current_user.admin?
      if @article.user != current_user || !@article.pendente?
        redirect_to meus_artigos_path, alert: "Você não tem permissão para realizar esta ação."
      end
    end
end
