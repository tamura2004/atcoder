record Player, id : Int32, num : Int32, bet : Array(Int32)

n = gets.to_s.to_i
players = Array.new(n) do |i|
  num = gets.to_s.to_i
  bet = gets.to_s.split.map(&.to_i)
  Player.new(i + 1, num, bet)
end
x = gets.to_s.to_i

winner = players.select do |player|
  player.bet.includes?(x)
end

if winner.empty?
  puts 0
  exit
end

mini = winner.map(&.num).min
ans = winner.select(&.num.== mini).map(&.id)

puts ans.size
puts ans.join(" ")
