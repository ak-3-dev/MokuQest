class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @quests = @user.quests.order(created_at: :desc)
    @ai_plan = @user.ai_plans
                    .where(plan_date: Date.current)
                    .order(created_at: :desc)
                    .first
    if @ai_plan.present?

      today_day =
        (Date.current - @ai_plan.started_on).to_i + 1

      @plan_completed =
        today_day > @ai_plan.period.to_i

      @today_tasks =
        @ai_plan.ai_tasks.where(day: today_day)

      @today_day = today_day
      @total_days = @ai_plan.period.to_i

      @plan_progress =
        ((@today_day.to_f / @total_days) * 100).round

      @plan_progress = 100 if @plan_progress > 100

      @completed_tasks = @today_tasks.where(completed: true).count
      @total_tasks = @today_tasks.count

      @completion_rate =
        if @total_tasks.zero?
          0
        else
          (@completed_tasks.to_f / @total_tasks * 100).round
        end
    end
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