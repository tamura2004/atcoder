N = 30
M = 5

open("src/input.txt", "w") do |f|
  f.puts [N,M].join(" ")
  N.times do |i|
    f.puts [rand(0..1000), rand(0..1000), rand(1..3)].join(" ")
  end
  M.times do |i|
    f.puts [rand(0..1000), rand(0..1000), rand(1..3)].join(" ")
  end
end
