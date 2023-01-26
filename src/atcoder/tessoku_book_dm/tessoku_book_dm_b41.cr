x, y = gets.to_s.split.map(&.to_i64)
ans = [] of Tuple(Int64,Int64)

dfs = uninitialized (Int64, Int64) -> Nil
dfs = -> (x : Int64, y : Int64) do
  ans << {x,y}
  if x == 1 && y == 1
    return
  else
    if x < y
      dfs.call(x, y-x)
    else
      dfs.call(x-y, y)
    end
  end
end
dfs.call(x, y)
ans.pop
puts ans.size
puts ans.reverse.map(&.join(" ")).join("\n")
