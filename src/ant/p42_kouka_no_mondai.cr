alias Pair = Tuple(Int64, Int64)

def get_pair
  Pair.from(gets.to_s.split.map(&.to_i64))
end

n = gets.to_s.to_i
a = Array.new(n){ get_pair }.sort_by(&.last)

last = 0_i64
ans = 0_i64
a.each do |lo,hi|
  if last <= lo
    ans += 1
    last = hi
  end
end

puts ans
