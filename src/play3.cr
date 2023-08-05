require "crystal/multiset"

s = Multiset(Int32).sum
s << 3
s << 3
s << 5
s << 7
s << 9
s << 11

s.with_lower(2) do |upper|
  pp upper.acc
end
puts s.acc
