def f(b,i)
  b.bit(i).zero? ? "x" : "o"
end

def show(b)
  puts "#{f(b,0)} #{f(b,1)} #{f(b,2)} #{f(b,3)}"
  puts "#{f(b,11)}     #{f(b,4)}"
  puts "#{f(b,10)}     #{f(b,5)}"
  puts "#{f(b,9)} #{f(b,8)} #{f(b,7)} #{f(b,6)}"
end

def up(b)
  (b & 0b1111).popcount
end

def down(b)
  (b & 0b1111000000).popcount
end

def right(b)
  (b & 0b1111000).popcount
end

def left(b)
  (b & 0b111000000001).popcount
end

ans = 0_i64
(1<<12).times do |b|
  if up(b) == right(b) == down(b) == left(b) == 0
    show(b)
    ans += 1
  end
end

pp ans
