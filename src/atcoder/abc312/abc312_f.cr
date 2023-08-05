require "crystal/multiset"

n, m = gets.to_s.split.map(&.to_i64)
open_cans = Multiset(Int64).sum
openers = [] of Int64
close_cans = [] of Int64

n.times do
  t, x = gets.to_s.split.map(&.to_i64)
  open_cans << x if t == 0
  close_cans << x if t == 1
  openers << x if t == 2
end
close_cans.sort!
openers.sort!

ans = 0_i64
open_cans.with_upper(m) do |upper|
  chmax ans, upper.try &.acc || 0
end

while openers.size > 0
  opener = openers.pop
  while close_cans.size > 0 && opener > 0
    open_cans << close_cans.pop
    opener -= 1
  end

  m -= 1
  open_cans.with_upper(m) do |upper|
    chmax ans, upper.try &.acc || 0
  end
end

pp ans
