N,*G = $<.map &:to_i
M = Array.new(6,0) # visited

N.times do |i|
  next unless M[i].zero? # is visited

  M[i] = 1
  j = G[i]
  l = 1
  while i != j
    M[j] = 1
    j = G[j]
    l += 1
  end

  if l.odd?
    puts -1
    exit
  end
end

puts N/2