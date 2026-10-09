class AiPlansController < ApplicationController
  def new
    @ai_plan = AiPlan.new
  end

  def create
    @quest = current_user.quests.build(
      title: ai_plan_params[:goal],
      body: "#{ai_plan_params[:goal]}を達成するためのAIクエスト"
    )

    @ai_plan = current_user.ai_plans.build(
      ai_plan_params.merge(
        plan_date: Date.current,
        started_on: Date.current,
        current_day: 1,
        quest: @quest
      )
    )

    if @ai_plan.valid?
      @quest.save!
      @ai_plan.save!

      GenerateAiQuestJob.perform_later(@ai_plan.id)

      redirect_to ai_plan_path(@ai_plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @ai_plan = current_user.ai_plans.find(params[:id])

    today_day = (Date.current - @ai_plan.started_on).to_i + 1
    total_days = @ai_plan.period.to_i

    @period_ended = today_day > total_days

    @today_tasks =
      if today_day.between?(1, total_days)
        @ai_plan.ai_tasks.where(day: today_day)
      else
        @ai_plan.ai_tasks.none
      end

    @incomplete_tasks = @ai_plan.ai_tasks
                                .where(completed: false)
                                .where("day < ?", today_day)
                                .order(:day, :id)

    expected_tasks = total_days * 3

    @quest_cleared =
      expected_tasks.positive? &&
      @ai_plan.ai_tasks.count == expected_tasks &&
      !@ai_plan.ai_tasks.exists?(completed: false)
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
