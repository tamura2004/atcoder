def r;gets.split.map &:to_i;end
def rr(n);n.times.map{r};end
N,M = r
S = rr(N)
S.sort_by! &:first

c = M
m = 0
S.each do |(a,b)|
  if b < c
    c -= b
    m += b * a
  else
    m += c * a
    p m
    exit
  end
end
