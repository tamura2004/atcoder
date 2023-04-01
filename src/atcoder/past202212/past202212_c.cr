n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
ans = Set(Int64).new

(0...n).each do |i|
  (i+1...n).each do |j|
    (j+1...n).each do |k|
      ans << a[i] * a[j] * a[k]
    end
  end
end

pp ans.size
