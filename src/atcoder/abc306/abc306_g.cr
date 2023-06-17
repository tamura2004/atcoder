# サイクルが2p5q
require "crystal/graph"

t = gets.to_s.to_i64
t.times do
  n, m = gets.to_s.split.map(&.to_i64)
  g = n.to_g

  m.times do
    v, nv = gets.to_s.split.map(&.to_i64)
    g.add v, nv, both: false
  end

  q = Deque.new([{0, 0}])
  cycle = Array.new(n + 1, false)
  cycle = Set(Int32).new
  while q.size > 0
    v, len = q.shift
    next if len > n
    if v == 0 && len > 0
      cycle << len
    else
      g.each(v) do |nv|
        q << {nv, len + 1}
      end
    end
  end
  o(cycle)
end

def o(cycle)
  cycle.each do |i|
    while i % 2 == 0
      i //= 2
    end
    while i % 5 == 0
      i //= 5
    end
    if i == 1
      puts "Yes"
      return
    end
  end
  puts "No"
end

