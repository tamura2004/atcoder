require "crystal/range_to_tuple"

# スパーステーブル
#
# 区間最大、区間最小、区間GCDを、前処理O(N log N)、クエリO(1)で処理。
# 演算は`Proc`で与えるが、単位元を`nil`としている。
#
# クエリが高速なので、`#next_change`等二分探索と併用できる。
#
# ```
# a = [5, 3, 7, 9, 6, 4, 1, 2, 100]
# sp = SparseTable(Int32).min(a)
# sp[0..2].should eq 3
# sp[2..4].should eq 6
# sp[0..].should eq 1
# sp[7..].should eq 2
# sp[..2].should eq 3
# sp[..0].should eq 5
#
# sp = SparseTable(Int32).max(a)
# sp[0..2].should eq 7
# sp[2..4].should eq 9
# sp[0..].should eq 100
# sp[7..].should eq 100
# sp[..2].should eq 7
# sp[..0].should eq 5
# ```
struct SparseTable(T)
  getter n : Int32
  getter m : Int32
  getter a : Array(T)
  getter dp : Array(Array(T?))
  getter f : Proc(T?, T?, T?) # mi

  # 区間最小
  def self.min(a)
    new(a, Proc(T?, T?, T?).new { |a, b| a && b ? Math.min(a, b) : nil })
  end

  # 区間最大
  def self.max(a)
    new(a, Proc(T?, T?, T?).new { |a, b| a && b ? Math.max(a, b) : nil })
  end

  # 区間GCD
  def self.gcd(a)
    new(a, Proc(T?, T?, T?).new { |a, b| a && b ? a.gcd(b) : nil })
  end

  def initialize(@a, @f)
    @n = a.size
    @m = Math.ilogb(Math.pw2ceil(n)) + 1
    @dp = Array.new(m) { Array.new(n, nil.as(T?)) }

    m.times do |i|
      n.times do |j|
        if i.zero?
          dp[i][j] = a[j]
        else
          jj = j + 2 ** (i - 1)
          next unless jj < n

          dp[i][j] = f.call(dp[i - 1][j], dp[i - 1][jj])
        end
      end
    end
  end

  def solve(r)
    lo, hi = RangeToTuple.from(r, min: 0, max: n)
    i = Math.ilogb(hi - lo)
    f.call(dp[i][lo], dp[i][hi - 2**i])
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    solve(r).not_nil!
  end

  # min,gcd等、単調減少する場合の次の変化点
  def next_change(s, t) : T
    v = self[s..t]
    (t...n).bsearch { |k| self[s..k] < v } || T.new(n)
  end
end
