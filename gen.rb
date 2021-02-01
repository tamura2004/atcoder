N = 100
W = 10000
C = 50
open("sample.txt", "w") do |f|
  f.puts [N, W, C].join(" ")
  N.times do
    f.puts "#{rand(W) + 1} #{rand(W) + 1} #{rand(50) + 1}"
  end
end
