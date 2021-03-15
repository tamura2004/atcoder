

2.upto(1000000) do |n|
  a = Math.sqrt(n).ceil.to_i
  if a ** 2 < n
    raise "n = #{n}, a = #{a}"
  end
end
