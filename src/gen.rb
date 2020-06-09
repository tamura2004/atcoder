N = 100000

open("src/input.txt", "w") do |f|
  f.puts [N,N-1].join(" ")
  (N-1).times do |i|
    a = 1
    b = i + 2
    f.puts [a,b,1270].join(" ")
  end
end
