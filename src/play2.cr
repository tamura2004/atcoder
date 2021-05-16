def dfs(x, &f : Int32 -> Int32)
  return 1 if x == 1
  f.call(dfs(x - 1, &f))
end

ans = dfs(3) { |i| i * 2 }
pp ans
