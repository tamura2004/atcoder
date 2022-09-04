cnt = 45 ** 2 - gets.to_s.to_i
(1..9).each do |i|
  (1..9).each do |j|
    if i * j == cnt
      puts "#{i} x #{j}"
    end
  end
end
