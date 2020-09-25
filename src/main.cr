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
end

a = [1, 2, 3, 4, 5, 3]
obj = Ro.new(0, 10) { |i| i && a[i] }

assert!(obj.lo, 3) {}
assert!(obj.hi, 6) {}
assert!(obj.get(0), 0) {}
assert!(obj.get(1), 1) {}
assert!(obj.get(2), 2) {}
assert!(obj.get(3), 3) {}
assert!(obj.get(4), 4) {}
assert!(obj.get(5), 5) {}
assert!(obj.get(6), 3) {}
assert!(obj.get(7), 4) {}
assert!(obj.get(307), 4) {}
assert!(obj.get(300000007), 4) {}
