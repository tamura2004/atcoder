N = 20

open("src/input.txt", "w") do |f|
  f.puts [N,N].join(" ")
  f.puts "1 1"
  f.puts [N-1,N-1].join(" ")
  (N/4).times do
    f.puts ".###" * (N/4)
    f.puts "####" * (N/4)
    f.puts "##.#" * (N/4)
    f.puts "####" * (N/4)
  end
end
