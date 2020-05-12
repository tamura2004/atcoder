n,y = gets.split.map(&:to_i)

0.upto(n) do |i|
  0.upto(n-i) do |j|
    rest = y - i * 10000 - j * 5000
    next if rest < 0
    next if rest % 1000 != 0
    k = rest / 1000
    next if i + j + k != n
    puts [i,j,k].join(" ")
    exit
  end
end

puts "-1 -1 -1"
    

