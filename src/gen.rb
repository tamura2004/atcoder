N = 100000

open("src/input.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N){ rand 1..100000 }.join(" ")
  f.puts N
  N.times do
    b = rand 2..100000
    f.puts [b,b-1].join(" ")
  end

end
