n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
c = Array.new(n) do
  gets.to_s.to_i64
  gets.to_s.split.map(&.to_i64).to_set
end

potions = a.zip(0..).zip(c).sort_by(&.[0].[0]).reverse

q = gets.to_s.to_i
q.times do
  gets.to_s.to_i64
  d = gets.to_s.split.map(&.to_i64).to_set

  flag = false
  potions.each do |potion|
    if (d & potion[1]).empty?
      puts potion[0][1].succ
      flag = true
      break
    end
  end
  puts -1 if !flag
end
