def juryo_b(x)
  a = 1144
  b = 19.88
  c = 26.48
  d = 30.57

  ans = a
  x.times do |i|
    case
    when i <= 120
      ans += b
    when i <= 300
      ans += c
    else
      ans += d
    end
  end

  return ans.to_i
end

def premium(x)
  a = 9879.63
  b = 29.58

  ans = a
  x.times do |i|
    if 400 < i
      ans += b
    end
  end
  return ans.to_i
end

a = gets.to_s.split.map { |v| v.to_i }
a.each do |x|
  puts "#{x}, #{juryo_b(x)}, #{premium(x)}"
end
