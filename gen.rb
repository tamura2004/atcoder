N = 49
open("sample.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N) { |i| i + 2 }.join(" ")
end
