h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }

puts solve(h,w,a) ? "Yes" : "No"

def solve(h,w,a)
  yoko?(h,w,a) && tate?(h,w,a)
end

def yoko?(h,w,a)
  h.times.all? do |y|
    (w-1).times.all? do |x|
      a[y][x] + 1 == a[y][x+1] && mod7(a[y][x]) + 1 == mod7(a[y][x+1])
    end
  end
end

def tate?(h,w,a)
  (h-1).times.all? do |y|
    w.times.all? do |x|
      a[y][x] + 7 == a[y+1][x]
    end
  end
end

def mod7(x)
  (x - 1) % 7
end
