N = 8000

open("src/input.txt", "w") do |f|
  f.puts "TF" * (N/2)
  f.puts [rand(8000)-4000,rand(8000)-4000].join(" ")
end
