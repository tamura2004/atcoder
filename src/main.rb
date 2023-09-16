DATA.each_line do |line|
  puts "menuList.add(mutableMapOf(\"name\" to \"#{line.chomp}\", \"price\" to \"#{500 + 50 * rand(10)}円\"))"
end

__END__
唐揚げ
ハンバーグ
生姜焼き
ステーキ
野菜炒め
とんかつ
メンチカツ
チキンカツ
コロッケ
回鍋肉
麻婆豆腐
青椒肉絲
焼き魚
焼肉
