N = gets.to_i
L = gets.split.map(&:to_i)
K = gets.to_i

MAX = L.max
DIG = 10**15

def query(n)
    L.map{|l| l * DIG / n }.inject(:+) - K
end

ANS = (1..(MAX*DIG)).bsearch{|n| query(n)}
printf("%d\n", ANS)
printf("%d.%08d\n", ANS / DIG, ANS % DIG)