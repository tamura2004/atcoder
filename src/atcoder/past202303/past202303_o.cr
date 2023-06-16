require "crystal/range_update_range_sum"

class Problem
  getter n : Int64
  getter a : Array(Int64)
  getter cnt : Array(RURS)
  getter sum : RURS
  delegate "[]", to: sum

  def initialize(@n, @a)
    @cnt = Array.new(11) do
      RURS.new(n)
    end
    @sum = RURS.new(n)

    a.each_with_index do |v, i|
      cnt[v][i] = 1_i64
      sum[i] = v
    end
  end

  def sort(lo, hi)
    l = lo
    (0_i64..10_i64).each do |i|
      c = cnt[i][lo...hi]
      cnt[i][lo...hi] = 0_i64
      cnt[i][l...(l + c)] = 1_i64
      sum[l...(l + c)] = i
      l += c
    end
  end

  def reverse_sort(lo, hi)
    r = hi
    (0_i64..10_i64).each do |i|
      c = cnt[i][lo...hi]
      cnt[i][lo...hi] = 0_i64
      cnt[i][(r - c)...r] = 1_i64
      sum[(r - c)...r] = i
      r -= c
    end
  end
end

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
pr = Problem.new(n, a)

q.times do
  cmd, l, r = gets.to_s.split.map(&.to_i64)
  l -= 1

  case cmd
  when 1
    pr.sort(l, r)
  when 2
    pr.reverse_sort(l, r)
  when 3
    pp pr.sum[l...r]
  end
end
