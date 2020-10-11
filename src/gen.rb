N = 50

open("src/input.txt", "w") do |f|
  f.puts "9 50"
  dic = Array.new(10) { Array.new(rand(1..3)) { ("a".."z").to_a.sample }.join }
  N.times do
    a = Array.new(8) { rand(1..9) }
    b = a.map { |i| dic[i] }.join
    f.puts [a.join, b].join(" ")
  end
end
