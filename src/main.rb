klasses = [
  "ファイター",
  "ウィザード",
  "クレリック",
  "ローグ",
  "レンジャー",
  "パラディン",
  "バーバリアン",
  "ソーサラー",
  "モンク",
  "ウォーロック",
  "ドルイド",
  "バード",
]

klasses.each do |a|
  klasses.each do |b|
    next if a == b
    puts "'#{a}/#{b}',"
  end
end
