n = gets.to_s.to_i64

a = Array.new(n) do
  m = gets.to_s.to_i64
  h = Hash(Int64,Int64).new(0_i64)

  m.times do
    p, e = gets.to_s.split.map(&.to_i64)
    h[p] = e
  end

  h
end

# n = 100_000i64
# a = Array.new(n) do
#   h = Hash(Int64,Int64).new(0_i64)
#   [2i64,3i64,5i64,7i64,11i64].each do |k|
#     h[k] = rand(1000000000i64)
#   end
#   h
# end

maxi = Hash(Int64,Int64).new(0_i64)
a.each do |h|
  h.each do |k,v|
    chmax maxi[k], v
  end
end

# 各素数について個数の最大値の出現回数
cnt = Hash(Int64,Int64).new(0_i64)
a.each do |h|
  h.each do |k,v|
    cnt[k] += 1 if v == maxi[k]
  end
end

# 影響する素数（最大値の出現回数が1であるもの）
ps = Set(Int64).new
cnt.each do |k,v|
  ps << k if v == 1
end

# 影響する素数のベクトルをハッシュにしたもの
vecs = Set(UInt64).new
a.each do |h|
  vec = 0_u64
  h.each do |k,v|
    vec ^= k.hash if k.in?(ps) && v == maxi[k]
  # ps.each do |p|
  end
  vecs << vec
end

pp vecs.size
