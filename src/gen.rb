N = 100000

open("src/input.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N){ _1 + 1 }.shuffle.join(" ")
end
