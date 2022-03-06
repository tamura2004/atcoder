require "crystal/fenwick_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

quit("No") if a.sort != b.sort

def norm(a, b)
  ai = a.zip(0..).sort.map(&.last)
  bi = b.zip(0..).sort.map(&.last)
  ai.zip(bi).sort.map(&.last.+ 1)
end

cnt = inversion_number(norm(a, b))
puts cnt.odd? ? "No" : "Yes"

pp [3,1,1,5,1,1,2].uniq