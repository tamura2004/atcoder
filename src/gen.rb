open("src/input.txt", "w") do |f|
    f.puts 100000
    f.print "0"
    30000.times do
        f.print " 1"
    end
    30000.times do
        f.print " 2"
    end
    30000.times do
        f.print " 3"
    end
    9999.times do
        f.print " 4"
    end
end
