open("src/input.txt", "w") do |f|
    # f.puts "100000"
    # f.puts ([*?a..?z] * 3000).join
    
    C = %w(A B X Y)
    A = C.product(C).select do |a,b|
        a != b
    end.map do |a,b|
        sprintf("'%s'", a+b)
    end
    
    f.puts A.join(", ")
end