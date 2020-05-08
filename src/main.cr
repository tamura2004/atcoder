N = read_line.to_i64

def dfs(a, use, &block : Int64 ->)
  return if a > N
  if use == 0b111
    yield a
  end

  [3, 5, 7].each do |i|
    mask = 1 << ((i - 3)//2)
    dfs(a*10 + i, use | mask, &block)
  end
end

ans = 0i64
dfs(0i64, 0i64) do |a|
  ans += 1
end
puts ans
