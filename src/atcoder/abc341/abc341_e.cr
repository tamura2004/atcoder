# 文字と文字の間に注目する
# 両隣が同じなら1, 違うなら0とすると
# 良い文字列の条件は、区間の最大値が0と見ることができる
# １番目のクエリは両端２箇所しか変えないので
# 普通のセグ木に乗せることができる
#
# 点の区間から、間の区間への変換
#     0 1 2 3 4 5
# s = 0 1 1 0 1 1
# t = 0 1 0 0 1
#
# １番目のクエリ
# lo = 1, hi = 3の時
# lo-1, hiが更新される
# lo == 0, hi == n - 1ならスキップ
#
# ２番目のクエリ
# lo = 1 hi = 3の時
# st[lo...hi]
# lo = 0 hi = 5の時

require "crystal/st"

class Problem
  getter n : Int32
  getter s : String
  getter qs : Array(Tuple(Int64,Int64,Int64))

  def initialize(@n, @s, @qs)
  end

  def solve
    values = s.chars.map(&.to_i).each_cons_pair.map do |i, j|
      (i == j).to_unsafe
    end.to_a.map(&.to_i64)
    
    st = ST(Int64).new(values) do |x, y|
      Math.max(x, y)
    end

    qs.each do |cmd, lo, hi|
      lo -= 1
      hi -= 1
      case cmd
      when 1
        if lo != 0
          st[lo-1] ^= 1_i64
        end
        if hi != n - 1
          st[hi] ^= 1_i64
        end
      when 2
        if lo == hi
          puts :Yes
        else
          ans = st[lo...hi]
          yesno ans == 0
        end
      end
    end
  end
end

n, q = gets.to_s.split.map(&.to_i)
s = gets.to_s

if n == 1
  q.times do
    cmd, lo, hi = gets.to_s.split.map(&.to_i64)
    if cmd == 2
      puts :Yes
    end
  end
  exit
end

qs = Array.new(q) do
  cmd, lo, hi = gets.to_s.split.map(&.to_i64)
  { cmd, lo, hi }
end

Problem.new(n, s, qs).solve
