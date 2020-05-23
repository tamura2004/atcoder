N = 200000
Q = 10
open("src/input.txt", "w") do |f|
  f.puts N
  N.times do |i|
    f.puts [rand(1..(i+1)), rand(1..100)].join(" ")
  end
end
