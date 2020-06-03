N = 3000

open("src/input.txt", "w") do |f|
  f.puts [N,N].join(" ")
  f.puts Array.new(N){ rand(1..3) }.join(" ")
end
