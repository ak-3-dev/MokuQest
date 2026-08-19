class GenerateAiQuestJob < ApplicationJob
  queue_as :default

  def perform(ai_plan_id)
    ai_plan = AiPlan.find(ai_plan_id)

    tasks = OpenaiService.generate_quest(
      ai_plan.goal,
      ai_plan.period,
      ai_plan.level
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
  end
end
