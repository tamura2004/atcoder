macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i64
c = gets.to_s.split.map(&.to_i64)

ix = Hash(Int64,Int32).new
c.each_with_index do |v,i|
  ix[v] = i
end


min_cost = ix.keys.min
base_num = ix[min_cost]


ans = Array.new(9, 0_i64)
ans[base_num] = n // min_cost
n = n % min_cost


ix.values.sort.reverse_each do |i|
  next if base_num >= i
  cost = c[i]

  num = n // (cost - min_cost)
  chmin num, ans[base_num]

  ans[i] += num
  ans[base_num] -= num
  n -= num * (cost - min_cost)
end

cnt = [] of Int32
ans.each_with_index do |num, i|
  num.times do
    cnt << i + 1
  end
end

quit 0 if cnt.empty?
puts cnt.sort.reverse.join
