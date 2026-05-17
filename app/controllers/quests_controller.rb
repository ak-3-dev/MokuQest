class QuestsController < ApplicationController
  
  before_action :authenticate_user!

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

  private

  def quest_params
    params.require(:quest).permit(:title, :body, :status)
  end
end
