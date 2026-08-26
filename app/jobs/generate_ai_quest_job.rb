class GenerateAiQuestJob < ApplicationJob
  queue_as :default

  BATCH_DAYS = 10

  def perform(ai_plan_id)
    ai_plan = AiPlan.find(ai_plan_id)
    period = ai_plan.period.to_i

    start_day = 1

    while start_day <= period
      end_day = [start_day + BATCH_DAYS - 1, period].min

      previous_tasks = ai_plan.ai_tasks.order(:day)

      tasks = OpenaiService.generate_quest(
        ai_plan.goal,
        period,
        ai_plan.level,
        start_day: start_day,
        end_day: end_day,
        previous_tasks: previous_tasks
      )

      tasks["days"].each do |day_data|
        day_data["tasks"].each do |task|
          ai_plan.ai_tasks.create!(
            title: task["title"],
            description: task["description"],
            exp: task["exp"],
            completed: false,
            day: day_data["day"]
          )
        end
      end

      start_day = end_day + 1
    end
  end
end