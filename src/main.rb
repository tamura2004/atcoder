n = gets.to_i
$e = Array.new(n+1,0)
2.upto(n) do |i|
    cur = i
    2.upto(i) do |j|
        while cur % j == 0
            $e[j] += 1
            cur /= j
        end
    end
end

def num(m)
    $e.count{|v| v >= m - 1}
end

puts num(75) + num(25) * (num(3)-1) + num(15) * (num(5)-1) + num(5) * (num(5)-1) * (num(3)-2) / 2
