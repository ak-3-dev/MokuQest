class AiTasksController < ApplicationController
  def complete
    @task = AiTask.find(params[:id])

    @task.update!(completed: true)
    
    current_user.increment!(
      :exp,
      @task.exp
    )

    redirect_to ai_plan_path(@task.ai_plan),
                notice: "クエストを達成しました！"
  end
end