class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @quests = Quest.all.order(created_at: :desc)
    @quest = Quest.new
  end

  def create
    @quest = current_user.quests.build(quest_params)
    if @quest.save
      redirect_to quests_path, notice: "新しいクエスト「#{@quest.title}」を受注しました！"
    else
      @quests = Quest.all.order(created_at: :desc)
      render :index
    end
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    if @quest.update(quest_params)
      redirect_to quest_path(@quest), notice: "クエスト「#{@quest.title}」の作戦を変更しました！"
    else
      render :edit
    end
  end

  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy
    redirect_to quests_path, notice: "クエスト「#{@quest.title}」を取り消しました"
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :body, :status)
  end

  def ensure_correct_user
    @quest = Quest.find(params[:id])
    if @quest.user != current_user
      redirect_to quests_path, alert: "他人のクエストを操作する権限がありません。"
    end
  end
end
