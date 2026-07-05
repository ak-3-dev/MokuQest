class OpenaiService
  def self.generate_quest(goal, period, level)
    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    )

    response = client.chat(
      parameters: {
        model: "gpt-5-mini",
        messages: [
          {
            role: "user",
            content: <<~PROMPT
            あなたはギルドマスターです。

            目標: #{goal}
            期間: #{period}
            レベル: #{level}

            以下の条件を守ってください。

            ・期間の日数分の学習計画を作成する
            ・「期間」に入力された日数分だけdaysを作成する
            ・dayは1から始まる連番にする
            ・1日につきタスクを3個作成する
            ・前の日の続きになるように少しずつレベルアップする
            ・毎日違う内容にする
            ・1日1〜2時間で達成できる量にする
            ・初心者でも実行できる内容にする
            ・タスクは具体的にする
            
            以下のJSON形式のみで回答してください。

            {
              "days": [
                {
                  "day": 1,
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
                },
                {
                  "day": 2,
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