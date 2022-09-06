require "crystal/graph"

n,m,k = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv, origin: 0
end

# bit全探索してみる
(1<<n).times do |s|
  next unless s.popcount == k
  chk = true

  g.each do |v|
    next if s.bit(v) == 0

    g.each(v) do |nv|
      chk = false if s.bit(nv) == 1
    end
  end

  if chk
    n.times do |v|
      puts v if s.bit(v) == 1
    end
    exit
  end
end

raise "anything bad"

