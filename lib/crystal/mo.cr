# Mo's algolythm
#
# 長さnの数列に対しq回の区間クエリ[l, r)を処理する
# ただし[l,x)と[x,r)を高速にマージできない（SegTreeが使えない理由）
#
# ```
# https://atcoder.jp/contests/abc242/tasks/abc242_g
# n = 10
# a = [0,1,2,1,2,0,2,0,1,2]
# q = 6
# lr = [
#   {5, 9},
#   {4, 7},
#   {2, 5},
#   {3, 3},
#   {0, 5},
#   {0, 9}
# ]
# mo = Mo.new(n, q, lr)
# cnt = Array.new(n, 0_i64)
# ans = Array.new(q, 0_i64)
# tot = 0_i64
#
# mo.solve do |cmd, i|
#   case cmd
#   when Mo::ADD
#     cnt[a[i]] += 1
#     tot += 1 if cnt[a[i]].even?
#   when Mo::DEL
#     cnt[a[i]] -= 1
#     tot -= 1 if cnt[a[i]].odd?
#   when Mo::TOT
#     ans[i] = tot
#   end
# end
# ans # => [2,2,1,0,3,4]
# ```
class Mo
  ADD = 0
  DEL = 1
  TOT = 2

  LOGN = 20 # 2 ** LOGN >= MAX_n

  getter n : Int32                       # 数列の長さ
  getter m : Int32                       # 分割数
  getter q : Int32                       # クエリ数
  getter lr : Array(Tuple(Int32, Int32)) # クエリ
  getter ix : Array(Int32)               # クエリの処理順

  def initialize(@n, @q, @lr)
    @m = Math.max 1, n // Math.sqrt(q)
    # @ix = (0...q).to_a.sort_by do |i|
    #   l, r = lr[i]
    #   sign = (l // m).odd? ? -1 : 1
    #   {l // m, r * sign}
    # end
    ord = lr.map{|l,r| triangleorder(l,r)}
    @ix = (0...q).to_a.sort_by do |i|
      ord[i]
    end
  end

  def triangleorder(l, r)
    d = 0_i64
    s = (1i64 << LOGN) + 1
    while s > 1
      if l >= s
        d += (36i64 * s * s) >> 4
        l -= s
        r -= s
      elsif l + r > (s << 1)
        d += (24i64 * s * s) >> 4
        l = l + 1
        r = (s << 1) - r
        l, r = r, l
      elsif r > s
        d += (12i64 * s * s) >> 4
        l = s - l
        r = r - s - l
        l, r = r, l
      end
      s >>= 1
    end
    d += l + r - 1
    d
  end

  def solve
    lo = hi = 0
    ix.each do |i|
      l, r = lr[i]

      while l < lo
        lo -= 1
        yield ADD, lo
      end

      while hi < r
        yield ADD, hi
        hi += 1
      end

      while lo < l
        yield DEL, lo
        lo += 1
      end

      while r < hi
        hi -= 1
        yield DEL, hi
      end

      yield TOT, i
    end
  end
end
