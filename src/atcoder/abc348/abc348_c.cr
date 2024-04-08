n = gets.to_s.to_i64
b = Array.new(n) do
    a, c = gets.to_s.split.map(&.to_i64)
    { a, c }
end

cnt = Hash(Int64, Int64).new(Int64::MAX)
b.each do |a, c|
    chmin cnt[c], a
end

ans = cnt.values.max
pp ans
