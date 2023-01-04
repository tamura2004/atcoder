def f(n,m)
  return 0_i64 if n.zero?
  return n ** 3 if m.zero?
  f(n-1,m) + f(n,m-1)
end

8.times do |n|
  ans = [] of Int64 | Int32
  8.times do |m|
    ans << f(n,m)
  end
  puts ans.each_slice(2).map{|(i,j)|j-i}.join(" ")
end

