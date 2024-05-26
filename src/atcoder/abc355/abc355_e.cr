# n, lo, hi = gets.to_s.split.map(&.to_i64)
# lo += n
# hi += n + 1

# offset = 2 ** n
# i = 0
# ans = 0_i64

# while lo < hi
#   if lo.odd?
#     puts "? #{i} #{lo - offset}"
#     STDOUT.flush
#     t = gets.to_s.to_i64
#     ans += t
#     lo += 1
#   end
#   if hi.odd?
#     hi -= 1
#     puts "? #{i} #{hi - offset}"
#     STDOUT.flush
#     t = gets.to_s.to_i64
#     ans += t
#   end
#   lo >>= 1
#   hi >>= 1
#   offset >>= 1
# end

# puts "! #{ans % 100}"
# STDOUT.flush

require "crystal/priority_queue"

enum Move
  LoLeft
  LoRight
  HiLeft
  HiRight
  None
end

alias N = Tuple(Int32, Tuple(Int32,Int32), Tuple(Int32,Int32), Move)

lo = 1
hi = 7
pq = PriorityQueue(N).lesser
pq << N.new 0, {lo, hi}, {-1, -1}, Move::None
