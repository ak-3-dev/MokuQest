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

    GenerateAiQuestJob.perform_later(@ai_plan.id)

    redirect_to ai_plan_path(@ai_plan)
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

  def status
    @ai_plan = current_user.ai_plans.find(params[:id])

    total_tasks = @ai_plan.period.to_i * 3
    generated_tasks = @ai_plan.ai_tasks.count

    render json: {
      completed: generated_tasks >= total_tasks,
      generated_tasks: generated_tasks,
      total_tasks: total_tasks,
      generation_status: @ai_plan.generation_status
    }
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
