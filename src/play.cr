n = gets.to_s.to_i
a = Array.new(n){ gets.to_s.to_i - 1 }
idx = Array.new(n, 0)
a.each_with_index do |v, i|
  idx[v] = case i
           when 0 then 100000
           when 1 then 50000
           when 2 then 30000
           when 3 then 20000
           when 4 then 10000
           else        0
           end
end
puts idx.join("\n")
