require "crystal/grid"

h, w, k = gets.to_s.split.map(&.to_i64)
g = Array.new(h) { gets.to_s }

# 連続するK個をoにするために必要な個数
def query(s, k)
  n = s.size
  cnt = 0_i64
  ans = Int64::MAX

  n.times do |i|
    if s[i] == 'o'
      cnt += 1
    end

    if k - 1 <= i
      chmin ans, k - cnt
      if s[i - k + 1] == 'o'
        cnt -= 1
      end
    end
  end

  ans
end

ans = Int64::MAX

2.times do
  g.each do |row|
    row.split(/x+/).each do |s|
      chmin ans, query(s, k)
    end
  end

  g = g.map(&.chars).transpose.map(&.join)
  h, w = w, h
end

puts ans == Int64::MAX ? -1 : ans