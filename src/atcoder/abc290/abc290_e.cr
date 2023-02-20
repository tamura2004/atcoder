require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

b = (0...n).map{1}
ans = Problem.new(n,b).solve
ans -= Problem.new(n,a).solve
pp ans

class Problem
  getter n : Int32
  getter a : Array(Int32)

  def initialize(@n,@a)
  end

  def solve
    tot = n.to_st_sum
    cnt = n.to_st_sum

    rad = (0...n).map{|i|Math.min(i,n-i-1)+1}
    b = a.zip(0..).group_by(&.first).transform_values(&.map(&.last))
    ans = 0_i64
    b.each do |k, v|
      v.each do |i|
        if i < n // 2
          ans += tot[...i]
          tot[i] = 1_i64 + i
          cnt[i] = 1_i64
        elsif i == n // 2 && n.odd?
          ans += tot[...i]
          cnt[i] = 1_i64
        else
          ans += tot[...rad[i]]
          ans += cnt[rad[i]...i] * rad[i]
          cnt[i] = 1_i64
        end
      end
      v.each do |i|
        tot[i] = 0_i64
        cnt[i] = 0_i64
      end
    end
    ans
  end
end
