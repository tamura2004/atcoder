N = 1000000000
Q = 100
a = Array.new(N) { rand(1..100) }

open("sample.txt", "w") do |f|
  f.puts "#{N} #{Q}"
  (1...Q).each do |v|
    lo = rand(1..N)
    hi = rand(1..N)
    lo, hi = hi, lo unless lo < hi
    if rand < 0.5
      f.puts "2 #{lo} #{hi}"
    end
  end
end
