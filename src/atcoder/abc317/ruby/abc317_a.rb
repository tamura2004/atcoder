Potion = Struct.new(:id, :hp)
n, h, x = gets.split.map(&:to_i)
potions = gets.split.map(&:to_i).zip(1..).map do |v, i|
  Potion.new i, v
end
ans = potions.select do |potion|
  x <= h + potion.hp
end
pp ans.first.id
