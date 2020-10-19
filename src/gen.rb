N = 100000

open("src/input.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N) { 100000 }.join(" ")
end
