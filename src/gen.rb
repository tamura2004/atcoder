N = 200000
K = 300

open("src/input.txt", "w") do |f|
  f.puts "#{N} #{K}"
  f.puts Array.new(N) { 100000000 }.join(" ")
end
