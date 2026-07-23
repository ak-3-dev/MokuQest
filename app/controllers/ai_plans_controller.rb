class AiPlansController < ApplicationController
  def new
    @ai_plan = AiPlan.new
  end

  def create
    @quest = current_user.quests.create!(
      title: ai_plan_params[:goal],
      body: "#{ai_plan_params[:goal]}を達成するためのAIクエスト"
    )

    @ai_plan = current_user.ai_plans.create!(
      ai_plan_params.merge(
        plan_date: Date.current,
        started_on: Date.current,
        current_day: 1,
        quest: @quest
      )
    )

    tasks = OpenaiService.generate_quest(
      @ai_plan.goal,
      @ai_plan.period,
      @ai_plan.level
    )

    tasks["days"].each do |day_data|
      day_data["tasks"].each do |task|

        @ai_plan.ai_tasks.create!(
          title: task["title"],
          description: task["description"],
          exp: task["exp"],
          completed: false,
          day: day_data["day"]
        )
      end
    end

    redirect_to user_path(current_user),
                notice: "AIクエストを受注しました!"
  end

  def show
    @ai_plan = AiPlan.find(params[:id])

    unless @ai_plan.user == current_user
      redirect_to quests_path, alert: "閲覧できません。" and return
    end
    
    @today_tasks = @ai_plan.ai_tasks.where(
      day: @ai_plan.current_day
    )
  end

  private

  def ai_plan_params
    params.require(:ai_plan).permit(
      :goal,
      :period,
      :level
    )
  end
end
