n, l = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

(n-1).times do |i|
  if a[i] + a[i+1] >= l
    puts "Possible"

    (0...i).each do |j|
      puts j + 1
    end

    (i+1...n-1).reverse_each do |j|
      puts j + 1
    end

    puts i + 1
    exit
  end
end

puts "Impossible"
