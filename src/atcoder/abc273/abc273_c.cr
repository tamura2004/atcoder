n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

pre = Array.new(n, 0)
ix = Hash(Int64,Array(Int32)).new do |h,k|
  h[k] = [] of Int32
end

a.each_with_index do |v, i|
  ix[v] << i
end

cnt = Set(Int64).new

ix.keys.sort.reverse_each do |key|
  ix[key].each do |i|
    pre[i] = cnt.size
  end
  cnt << key
end

ans = Array.new(n, 0)
pre.each do |v|
  ans[v] += 1
end

puts ans.join("\n")