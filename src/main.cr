s = gets.to_s.chars.map(&.ord.- 'a'.ord)
t = gets.to_s.chars.map(&.ord.- 'a'.ord)
n = s.size

if (t.uniq - s.uniq).size > 0
  puts -1
  exit
end

nex = Array.new(n+1) { Array.new(26, -1) }
(n-1).downto(0) do |i|
  26.times do |j|
    nex[i][j] = nex[i+1][j]
    nex[i][j] = i if j == s[i]
  end
end

ans = 0_i64
lo = 0
t.each do |c|
  if nex[lo][c] != -1
    lo = nex[lo][c] + 1
  else
    ans += 1
    lo = 0
    lo = nex[lo][c] + 1
  end

  if n <= lo
    ans += 1
    lo = 0
  end
end

pp ans * n + lo



