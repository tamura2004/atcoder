require "crystal/range"

# check(x)について二分探索
# 5つの能力について少なくとも一人がx以上
# 能力値がx以上なら1、未満なら0として5ビットでエンコード

class Problem
  getter n : Int32
  getter a : Array(Array(Int32))

  def initialize(@n, @a)
  end

  def solve
    lo = 0_i64
    hi = 1e10.to_i64
    (lo..hi).reverse_bsearch{|x|check(x)}
  end

  def check(x)
    masks = Array.new(n) do |i|
      cnt = 0
      (0...5).map do |j|
        next if a[i][j] < x
        cnt |= 1 << j
      end
      cnt
    end

    cnt = Hash(Int32,Int32).new(0)
    masks.each { |mask| cnt[mask] += 1}

    (1<<5).times do |m1|
      (1<<5).times do |m2|
        (1<<5).times do |m3|
          next unless m1 | m2 | m3 == 0b11111
          return true if cnt[m1] > 0 && cnt[m2] > 0 && cnt[m3] > 0
        end
      end
    end
    false
  end
end

n = gets.to_s.to_i
a = Array.new(n) {gets.to_s.split.map(&.to_i)}
ans = Problem.new(n,a).solve
pp ans