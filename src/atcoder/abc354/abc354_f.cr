require "crystal/st"
require "crystal/cc"

t = gets.to_s.to_i64
t.times do
  m = gets.to_s.to_i64
  a = gets.to_s.split.map(&.to_i64).compress

  left = Array.new(m+1, 0_i64).to_st_max
  right = Array.new(m+1, 0_i64).to_st_max

  lis = Array.new(m, 1_i64)

  (0...m).each do |i|
    l = (left[...a[i]]? || 0_i64) + 1_i64
    lis[i] = l
    left[a[i]] = l
  end

  (0...m).reverse_each do |i|
    r = (right[a[i]+1..]? || 0_i64) + 1_i64
    lis[i] += r
    right[a[i]] = r
  end

  maxi = lis.max

  ans = [] of Int64
  m.times do |i|
    if lis[i] == maxi
      ans << i
    end
  end

  puts ans.size
  puts ans.map(&.succ).join(" ")
end

