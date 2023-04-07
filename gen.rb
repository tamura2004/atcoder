N = 7
Q = 10
a = Array.new(N) { rand(1..100) }

open("sample.txt", "w") do |f|
  f.puts "#{N} #{Q}"
  (1...Q).each do |v|
    lo = rand(1..N)
    hi = rand(1..N)
    d = rand(1..9)
    lo, hi = hi, lo unless lo < hi
    f.puts "#{lo} #{hi} #{d}"
  end
end
