N = 30
open("sample.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N) { rand(1..10) }.join(" ")
end
