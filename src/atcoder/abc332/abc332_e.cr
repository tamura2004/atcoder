n, d = gets.to_s.split.map(&.to_i64)
w = gets.to_s.split.map(&.to_i64)
sum = w.sum

ans = 1e100
ave = sum / d

def bunsan(cnt : Array(Int64), ave : Float64, n : Int64): Float64
  cnt.sum do |v|
    (v - ave) ** 2
  end / n
end


(0...d).to_a.each_repeated_permutation(n) do |wake|
  cnt = Array.new(d, 0_i64)
  n.times do |i|
    cnt[wake[i]] += w[i]
  end
  next if cnt.any?(&.zero?)
  chmin ans, bunsan(cnt, ave, d)
end

pp ans
