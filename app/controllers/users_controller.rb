class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :ensure_correct_user, only: [ :edit, :update ]

  def show
    @quests = @user.quests.order(created_at: :desc)

    @ai_plan = @user.ai_plans
                    .where("started_on <= ?", Date.current)
                    .order(started_on: :desc, created_at: :desc)
                    .first

    if @ai_plan.present?
      @today_day =
        (Date.current - @ai_plan.started_on).to_i + 1

      @total_days = @ai_plan.period.to_i

      @today_tasks =
        if @today_day.between?(1, @total_days)
          @ai_plan.ai_tasks.where(day: @today_day)
        else
          @ai_plan.ai_tasks.none
        end

      @past_incomplete_tasks =
        @ai_plan.ai_tasks
                .where("day < ?", @today_day)
                .where(completed: false)
                .order(:day, :id)

      expected_tasks = @total_days * 3

      @plan_completed =
        expected_tasks.positive? &&
        @ai_plan.ai_tasks.count == expected_tasks &&
        !@ai_plan.ai_tasks.exists?(completed: false)
      @plan_progress =
        [(@today_day.to_f / @total_days * 100).round, 100].min

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
  end

  def update
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
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if @user != current_user
      redirect_to user_path(current_user), alert: "他人の編集画面にはアクセスできません。"
    end
  end
end
