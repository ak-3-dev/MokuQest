# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "『MokuQuest』の世界に聖なるシードデータを流し込みます..."

Quest.delete_all
User.delete_all
Admin.delete_all

me = User.create!(
  name: "新米冒険者",
  email: "hero@example.com",
  password: "password",
  password_confirmation: "password"
)
puts "テスト用ログインユーザーを作成しました（email: hero@example.com）"

me.quests.create!([
  { title: "HTML/CSSのモックアップ作成", body: "AI生成クエスト[Day 1]: ポートフォリオのワイヤーフレームを元に、基本的なHTML構造と静的なコーディングを完了させる。" },
  { title: "Rubyの基礎ロジック習得", body: "AI生成クエスト[Day 5]: 配列やハッシュ、繰り返し処理を理解し、簡単な条件分岐プログラムをエラーなしで実行する。" },
  { title: "【最優先】RailsでのCRUD機能の実装", body: "AI生成クエスト[Day 10]: データベースと連携させ、投稿の作成・一覧表示・詳細表示・更新・削除の基本機能を完成させる。" } 
])
puts "あなたのクエストデータを3件登録しました。"

companion1 = User.create!(
  name: "sato_developer",
  email: "sato@example.com",
  password: "password",
  password_confirmation: "password"
)

companion2 = User.create!(
  name: "Miku_Code",
  email: "miku@example.com",
  password: "password",
  password_confirmation: "password"
)
puts "他のユーザー（2名）を作成しました。"

companion1.quests.create!([
  { title: "毎日の継続学習（3時間）", body: "AI生成クエスト[習慣化]: 今日もタイマーをセットし、集中して3時間のコード記述とエラー解決に挑む。" },
  { title: "基本情報技術者試験の過去問演習", body: "AI生成クエスト[資格対策]: 午前問題のアルゴリズム分野を10問解き、間違えた箇所の解説をノートにまとめる。" }
])

companion2.quests.create!([
  { title: "Git/GitHubでのブランチ運用", body: "AI生成クエスト[チーム開発]: 新しいトピックブランチを作成し、競合（コンフリクト）を起こさずにプルリクエストを送信・マージする。" }
])
puts "📜 タイムライン用のクエストデータを配置しました。"

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password" 
end
puts "👑 ギルドマスター（管理者）を作成しました（email: admin@example.com）"

puts "✨ すべての検証用データの投入が完了しました！"