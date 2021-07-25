require "crystal/grid"
require "crystal/graph"
require "crystal/bit_set"

n = gets.to_s.to_i
k = gets.to_s.to_i
s = (1..n).map { gets.to_s }
grid = Grid.new(n,n,s)

to_index = -> (y : Int32, x : Int32) {
  y * n + x
}

from_index = -> (i : Int32) {
  { i // n, i % n }
}

# 開始点を初期化
q = Deque(UInt64).new
seen = Set(UInt64).new

(n*n).times do |i|
  next if grid.wall?(i)
  s = 1_u64 << i
  q << s
  seen << s
end

ans = 0_i64

# def debug(s)
#   puts "----"
#   puts sprintf("%016b", s).chars.each_slice(4).map(&.join).join("\n")
# end

# bfs
while q.size > 0
  s = q.shift
  if s.popcount == k
    ans += 1
  else
    (n*n).times do |v|
      next if s.bit(v) == 0
      grid.each(v) do |nv|
        next if s.bit(nv) == 1
        ns = s | (1_u64 << nv)
        next if ns.in?(seen)
        q << ns
        seen << ns
      end
    end
  end
end

pp ans


