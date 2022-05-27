# ABC106_D

# イベントソート用に種別をenumで定義
enum EventType
  Train
  Towns
end

# イベントのリストを定義
events = [] of Tuple(Int32, EventType, Int32, Int32)

# 問題の入力を読み込み
n, m, q = gets.to_s.split.map(&.to_i)

# 列車の情報をイベントに追加
m.times do
  left, right = gets.to_s.split.map(&.to_i.pred)
  events << {right, EventType::Train, left, -1}
end

# クエリ（左右の都市）をイベントに追加
q.times do |index|
  left, right = gets.to_s.split.map(&.to_i.pred)
  events << {right, EventType::Towns, left, index}
end

# 右端の昇順、イベント種類順（列車＞都市）順にソート
events.sort!

# 始発駅の数
stations = Array.new(500, 0_i64)

# 回答
answers = Array.new(q, -1i64)

# イベントを順次処理
events.each do |right, event, left, index|
  case event
  when .train? # enum定義時に小文字の問い合わせメソッドが定義される
    stations[left] += 1
  when .towns?
    answers[index] = stations[left..right].sum
  end
end

puts answers.join("\n")
