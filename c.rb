N = gets.to_i

H = Hash.new(false)
(1..9).each do |i|
    (1..9).each do |j|
        H[i*j] = true
    end
end

puts H[N] ? "Yes" : "No"
