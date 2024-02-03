n = gets.to_s.to_i64
events = Array.new(n) { gets.to_s.split.map(&.to_i64) }.reverse

actions = Array.new(n, 0)
monsters = Array.new(n, 0)

events.each.with_index do |(t, x), i|
  x -= 1
  case t
  when 1
    if monsters[x] > 0
      actions[i] = 1
      monsters[x] -= 1
    end
  when 2
    monsters[x] += 1
  end
end

if monsters.sum > 0
  pp -1
else
  events.reverse!
  actions.reverse!
  potion_num = 0
  potion_min = 0

  n.times do |i|
    if actions[i] == 1
      potion_num += 1
      chmax potion_min, potion_num
    elsif events[i][0] == 2
      potion_num -= 1
    end
  end

  pp potion_min
  ans = [] of Int32
  n.times do |i|
    next if events[i][0] == 2
    ans << actions[i]
  end
  puts ans.join(" ")
end
