n, m = gets.to_s.split.map { |v| v.to_i }
$g = Array.new(n) { [] }
$goal = [false] * n

m.times do
  a, b = gets.to_s.split.map { |v| v.to_i - 1 }
  $g[a] << b
end

dfs = ->(v) do
  return 0 if $goal[v]

  $g[v].sum do |nv|
    next 0 if $goal[nv]
    $goal[nv] = true
    dfs[nv]
  end
end

ans = n.times.sum do |v|
  $goal = [false] * n
  dfs[v]
end

pp ans
