require "spec"
require "crystal/mo"

describe Mo do
  it "usage" do
    # https://atcoder.jp/contests/abc242/tasks/abc242_g
    n = 10
    a = [0, 1, 2, 1, 2, 0, 2, 0, 1, 2]
    q = 6
    lr = [
      {5, 10},
      {4, 8},
      {2, 6},
      {3, 4},
      {0, 6},
      {0, 10},
    ]

    cnt = Counter.new(n,a)
    ans = Array.new(q, 0_i64)
    mo = Mo.new(n, q, lr)

    mo.solve do |cmd, i|
      case cmd
      when CMD::ADD
        cnt.add(i)
      when CMD::DEL
        cnt.del(i)
      when CMD::TOT
        ans[i] = cnt.tot
      end
    end
    ans.should eq [2, 2, 1, 0, 3, 4]
  end
end

# https://atcoder.jp/contests/abc242/tasks/abc242_g
class Counter
  getter n : Int32
  getter a : Array(Int32)
  getter cnt : Array(Int64)
  getter tot : Int64

  def initialize(@n,@a)
    @cnt = Array.new(n, 0_i64)
    @tot = 0_i64
  end

  def add(i)
    cnt[a[i]] += 1
    @tot += 1 if cnt[a[i]].even?
  end

  def del(i)
    cnt[a[i]] -= 1
    @tot -= 1 if cnt[a[i]].odd?
  end
end
