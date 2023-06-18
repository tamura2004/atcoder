n,m = gets.to_s.split.map(&.to_i64)

seen = Array.new(n, false)
seen[0] = true

dfs = uninitialized (Int32) -> Nil
dfs = -> (v : Int32) do
  if v != 0
    puts v + 1
    STDOUT.flush
  end

  if v == n - 1
    gets
    exit
  end
  
  g = gets.to_s.split.map(&.to_i)
  return if g.size == 1

  g[1..].each do |nv|
    nv -= 1
    next if seen[nv]
    seen[nv] = true
    dfs.call(nv)

    puts v + 1
    STDOUT.flush
    gets
  end
end
dfs.call(0)