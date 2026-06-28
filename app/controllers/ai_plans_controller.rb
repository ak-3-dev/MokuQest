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
        quest: @quest
      )
    )

    tasks = OpenaiService.generate_quest(
      @ai_plan.goal,
      @ai_plan.period,
      @ai_plan.level
    )

    tasks["today_tasks"].each do |task|
      @ai_plan.ai_tasks.create!(
        title: task["title"],
        description: task["description"],
        exp: task["exp"],
        completed: false
      )
    end

    redirect_to user_path(current_user),
                notice: "AIクエストを受注しました!"
  end

  def show
    @ai_plan = AiPlan.find(params[:id])
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
