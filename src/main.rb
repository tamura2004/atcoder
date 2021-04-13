t = gets.to_s.to_i
t.times do |i|
  n = gets.to_s.to_i
  a = gets.to_s.split.map{ |v| v.to_i }

  cnt = 0
  ans = 0
  a.each do |v|
    i = cnt.to_s.size
    j = v.to_s.size
    case
    when i > j
      ans += i - j
      nex = v * 10 ** (i - j)
      if cnt >= nex
        ans += 1
        cnt = nex * 10
      else
        cnt = nex
      end
    when i == j
      case
      when cnt < v
        cnt = v
      when cnt >= v
        ans += 1
        cnt = v * 10
      else
        raise "bad"
      end
    when i < j
      cnt = v
    else
      raise "bad"
    end
  end
  puts "Case ##{i+1}: #{ans}"
end
