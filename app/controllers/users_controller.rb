class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @quests = @user.quests.order(created_at: :desc)
  end

  def edit
    @User = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      latest_quest = @user.quests.order(created_at: :desc).first
      if latest_quest
        redirect_to quest_path(latest_quest), notice: "ユーザー情報を更新しました。"
      else
        redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).parmit(:name, :email)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user), alert: "他人の編集画面にはアクセスできません。"
    end
  end
end