require "crystal/trie"

n = gets.to_s.to_i64
s = gets.to_s.split.sort
tr = Trie(Int64).new

ans = 0_i64
s.each do |ss|
  ans += tr.sum(ss)
  tr << ss
end

pp ans