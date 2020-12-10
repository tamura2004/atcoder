# a := ２の倍数のうち３の倍数でないもの
# b := ３の倍数のうち２の倍数でないもの
# c := ６の倍数

a = [] of Int32
b = [] of Int32
c = [] of Int32

2.upto(30000) do |i|
  a << i if i % 2 == 0 && i % 3 != 0
  b << i if i % 3 == 0 && i % 2 != 0
  c << i if i % 3 == 0 && i % 2 == 0
end

pp [a,b,c].map(&.size).join(" ")

n = gets.to_s.to_i

ans = case n
when 3
  [2, 5, 63]
when .even?
  case n // 2
  when .even?
    a.first(n//4*2) + b.first(n//4*2)
  when .odd?
    a.first((n//4+1)*2) + b.first(n//4*2)
  end
when .odd?
  case n // 2
  when .even?
    a.first(n//4*2) + b.first(n//4*2) + [6]
  when .odd?
    a.first((n//4+1)*2) + b.first(n//4*2) + [6]
  end
end

# puts ans.try(&.sort.join(" "))
