N = 1000
M = 1000
open("src/input.txt", "w") do |f|
  f.puts [N,M].join(" ")
  M.times do
    f.puts "."*N
    # f.puts Array.new(2){ rand(N) + 1 }.join(" ")
  end
end
