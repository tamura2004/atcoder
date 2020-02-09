def dist(a,b,c)
    return ((c-a)*((b-a).conj)/((b-a).abs)).imag.abs
end

o = Complex.rect(*gets.split.map(&:to_i))
n = gets.to_i
c = n.times.map do |i|
    Complex.rect(*gets.split.map(&:to_i))
end

ans = 1000
n.times do |i|
    j = (i + 1) % n
    d = dist(c[i],c[j],o)
    ans = d if ans > d
end
printf("%.12f\n", ans)
