# a := ２の倍数のうち３の倍数でないもの
# b := ３の倍数のうち２の倍数でないもの

a = [] of Int32
b = [] of Int32

2.upto(20000) do |i|
  a << i if i % 2 == 0 && i % 3 != 0
  b << i if i % 3 == 0 && i % 2 != 0
end

n = gets.to_s.to_i

ans = case n
when 3
  [2, 5, 63]
when .even?
  case n // 2
  when .even?
    a.first(n//4) + b.first(n//4)
  when .odd?
    a.first(n//4+1) + b.first(n//4)
  end
when .odd?
  case n // 2
  when .even?
    a.first(n//4) + b.first(n//4) + [6]
  when .odd?
    a.first(n//4+1) + b.first(n//4) + [6]
  end
end

puts ans.join(" ")
