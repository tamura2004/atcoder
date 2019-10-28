N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort
F = gets.split.map(&:to_i).sort_by{|v|-v}

T = A.zip(F).map{|a,f|[a*f,a,f]}.sort_by{|v|-v[0]}

def query(n)
    k = 0
    T.each do |t|
        break if t[0] <= n
        k += -(-(t[0] - n)/t[2])
        return false if k > K
    end
    true
end

puts (0..10**12).bsearch{ |n|
    query(n)
}