N = 1000
open("sample.txt", "w") do |f|
  f.puts [N, N, N].join(" ")
  f.puts "1 1 1000 1000"
  N.times do
    f.puts "." * N
  end
end
