class Ro
  getter lo : Int32
  getter hi : Int32
  getter cycle : Int32
  getter memo : Hash(Int32, Int32)
  getter a : Array(Int32)

  def initialize(init, limit, &block : Int32 -> Int32)
    @memo = Hash(Int32, Int32).new(-1)
    @a = Array(Int32).new(limit + 1, -1)
    @lo = 0
    @hi = 0
    @cycle = 0

    a[0] = init
    memo[init] = 0
    limit.times do |i|
      nv = a[i + 1] = block.call(a[i])
      if memo[nv] == -1
        memo[nv] = i + 1
      else
        @lo = memo[nv]
        @hi = i + 1
        @cycle = hi - lo
        return
      end
    end
    raise "limit exceed"
  end

  def get(i : Int)
    return a[i] if i < hi
    j = (i - lo) % cycle + lo
    a[j]
  end

  # https://atcoder.jp/contests/abc030/tasks/abc030_d
  # for huge i (i.e. 10^100000)
  # need hi <= i, if i < hi -> undefined
  # mod = i % cycle
  def at_mod(mod : Int)
    offset = (mod - lo) % cycle
    get(lo + offset)
  end
end
