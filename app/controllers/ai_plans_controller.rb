class AiPlansController < ApplicationController
  def new
    @ai_plan = AiPlan.new
  end

  def create
    @ai_plan = current_user.ai_plans.create!(
      ai_plan_params
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

    redirect_to @ai_plan
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
