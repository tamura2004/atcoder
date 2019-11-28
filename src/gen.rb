N,L = 300,1000
Q = 30
open("src/input.txt", "w") do |f|
    f.puts "#{N} #{N-2} #{L}"
    (N-2).times do |i|
        f.puts "#{i+1} #{i+2} #{rand(10)*100+100}"
    end
    f.puts Q
    Q.times do |i|
        f.puts "#{rand(N)+1} #{rand(N)+1}"
    end
end
