class OpenaiService
  def self.generate_quest(goal, period, level, start_day:, end_day:, previous_tasks: [])
    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    )

    previous_tasks_text =
      if previous_tasks.any?
        previous_tasks.map do |task|
          "Day#{task.day}: #{task.title}"
        end.join("\n")
      else
        "なし"
      end

    response = client.chat(
      parameters: {
        model: "gpt-5-mini",
        response_format: { type: "json_object" },
        messages: [
          {
            role: "user",
            content: <<~PROMPT
              あなたはギルドマスターです。

              目標: #{goal}
              全体の期間: #{period}日
              現在のレベル: #{level}

              今回は全体計画のうち、
              Day#{start_day}〜Day#{end_day} のクエストだけを作成してください。

              すでに作成済みのクエスト:
              #{previous_tasks_text}

              以下の条件を守ってください。

              ・最終的に#{period}日間で目標を達成できるようにする
              ・今回はDay#{start_day}〜Day#{end_day}だけ作成する
              ・dayは#{start_day}から#{end_day}までの連番にする
              ・1日につきタスクを3個作成する
              ・前の日の続きになるように少しずつレベルアップする
              ・すでに作成済みのクエストと同じ内容をなるべく避ける
              ・毎日違う内容にする
              ・1日1〜2時間で達成できる量にする
              ・初心者でも実行できる内容にする
              ・タスクは具体的にする

              以下のJSON形式のみで回答してください。

              {
                "days": [
                  {
                    "day": #{start_day},
                    "tasks": [
                      {
                        "title": "タスク1",
                        "description": "詳細説明",
                        "exp": 100
                      },
                      {
                        "title": "タスク2",
                        "description": "詳細説明",
                        "exp": 100
                      },
                      {
                        "title": "タスク3",
                        "description": "詳細説明",
                        "exp": 100
                      }
                    ]
                  }
                ]
              }
            PROMPT
          }
        ]
      }
    )

    require "json"

    JSON.parse(
      response.dig("choices", 0, "message", "content")
    )
  end
end