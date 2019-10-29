N = gets.to_i
L = gets.split.map(&:to_i)
K = gets.to_i

def bsearch(lv, rv)
    100.times do
        mv = (lv + rv)/2
        yield(mv) ? rv = mv : lv = mv
    end
    rv
end

puts bsearch(1.0, 100.0){|v| v * 7 > 100}