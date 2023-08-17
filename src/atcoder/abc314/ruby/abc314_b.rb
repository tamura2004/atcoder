Player = Struct.new(:id, :num, :bet)
n = gets.to_i
players = Array.new(n) do |i|
  c = gets.to_i
  a = gets.split.map(&:to_i)
  Player.new(i + 1, c, a)
end
x = gets.to_i

winner = players.select do |player|
  player.bet.include?(x)
end

if winner.empty?
  puts 0
  exit
end

mini = winner.map(&:num).min
ans = winner.select do |player|
  player.num == mini
end

puts ans.size
puts ans.map(&:id).join(" ")
