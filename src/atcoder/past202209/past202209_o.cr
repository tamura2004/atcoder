require "crystal/fps"

def arr_to_fps(n, a)
  a.map_with_index do |v, i|
    arr = Array.new(n+1, 0_i64)
    arr[i.popcount] = v
    FPS.new(arr)
  end
end

def fast_zeta_transform(n, a)
  n.times do |i|
    (1<<n).times do |j|
      if j.bit(i) == 1
        a[j] += a[j ^ (1 << i)]
      end
    end
  end
end

def fast_moebius_transform(n, a)
  n.times do |i|
    (1<<n).times do |j|
      if j.bit(i) == 1
        a[j] -= a[j ^ (1 << i)]
      end
    end
  end
end

n, q = gets.to_s.split.map(&.to_i)
a = arr_to_fps n, gets.to_s.split.map(&.to_i64)
b = arr_to_fps n, gets.to_s.split.map(&.to_i64)
fast_zeta_transform(n,a)
fast_zeta_transform(n,b)
c = a.zip(b).map{|i,j|i*j}  
fast_moebius_transform(n,c)

q.times do
  x, y = gets.to_s.split.map(&.to_i)
  pp c[x][y]
end
