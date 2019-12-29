W = %w(M A R C H)
open("src/input.txt", "w") do |f|
    f.puts "100000"
    5.times do |i|
        20000.times do
            f.puts W[i]
        end
    end
end
