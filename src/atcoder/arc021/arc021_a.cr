# 縦横のドミノ型を全探索

a = Array.new(4){gets.to_s.split.map(&.to_i64)}
ans = "GAMEOVER"

4.times do |y|
  3.times do |x|
    ans = "CONTINUE" if a[y][x] == a[y][x+1]
  end
end

3.times do |y|
  4.times do |x|
    ans = "CONTINUE" if a[y][x] == a[y+1][x]
  end
end

puts ans

