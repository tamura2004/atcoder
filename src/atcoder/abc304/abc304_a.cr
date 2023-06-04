record Player, name : String, age : Int64, index : Int32

n = gets.to_s.to_i64
a = Array.new(n) do |i|
  name, age = gets.to_s.split
  Player.new name, age.to_i64, i
end

fst = a.min_by do |player|
  player.age
end

n.times do |i|
  puts a[(i + fst.index) % n].name
end
