class NoticesController < ApplicationController
  before_action :authenticate_user!, :require_admin
  before_action :set_notice, only: %i[ show edit update destroy ]

  def index
    @notices = Notice.order(created_at: :desc)
    @pagy, @notices = pagy(@notices, items: 15)
  end

  def show
  end

  def new
    @notice = Notice.new
  end

  def edit
  end

  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      redirect_to notices_url, notice: t("notices.create.notice")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @notice.update(notice_params)
      redirect_to notices_url, notice: t("notices.update.notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notice.destroy!
    redirect_to notices_url, notice: t("notices.destroy.notice")
  end

  private
    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:title, :content)
    end
end
