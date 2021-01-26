N = 300
M = 10 ** 9
open("sample.txt", "w") do |f|
  f.puts "#{N} #{M}"
  f.puts Array.new(N) { rand(M) + 1 }.join(" ")
end
