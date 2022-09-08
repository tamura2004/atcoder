N = 10
a = Array.new(N){ rand(1..100) }

open("sample.txt", "w") do |f|
  f.puts N
  f.puts a.join("\n")

  (1...N).each do |v|
    pv = rand(0...v)
    f.puts "#{pv} #{v}"
  end
end
