N = 500
s = Array.new(N) do
  Array.new(N) { rand(9).succ.to_s }
end

20000.times do
  y = rand(N)
  x = rand(N)
  s[y][x] = "#"
end

sy = rand(N)
sx = rand(N)
s[sy][sx] = "s"

gy = rand(N)
gx = rand(N)
s[gy][gx] = "g"

open("sample.txt", "w") do |f|
  f.puts "500 500"
  N.times do |i|
    f.puts s[i].join
  end
end
