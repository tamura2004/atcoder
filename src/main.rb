def dist(a,b,c)
    c -= a; b -= a
    b = b.conj/b.abs
    (c*b).imag.abs
end

def getc
    Complex.rect(*gets.split.map(&:to_i))
end

o = getc
n = gets.to_i
c = n.times.map { getc }

ans = 1000
n.times do |i|
    j = (i + 1) % n
    d = dist(c[i],c[j],o)
    ans = [ans, d].min
end
printf("%.12f\n", ans)
