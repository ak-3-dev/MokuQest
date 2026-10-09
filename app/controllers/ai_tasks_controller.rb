class AiTasksController < ApplicationController
  def complete
    @ai_plan = current_user.ai_plans.find(params[:ai_plan_id])
    @task = @ai_plan.ai_tasks.find(params[:id])

    AiTask.transaction do
      @task.lock!

      unless @task.completed?
        @task.update!(completed: true)
        current_user.increment!(:exp, @task.exp)
      end
    end

    redirect_back fallback_location: ai_plan_path(@ai_plan),
                  notice: "クエストを達成しました！"
  end
end