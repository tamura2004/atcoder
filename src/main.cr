require "crystal/tree"

struct Range(B, E)
  def &(b : self) : self
    Math.max(@begin, b.begin)..Math.min(@end, b.end)
  end

  def widen
    empty? ? self : (@begin - 1)..(@end + 1)
  end

  def empty?
    @begin > @end
  end
end

n = gets.to_s.to_i
g = Tree.new(n)

(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

# 頂点の値（未設定は-1）
num = [-1] * n
k = gets.to_s.to_i

root = 0
k.times do
  v, p = gets.to_s.split.map(&.to_i)
  num[v - 1] = p
  root = v - 1
end

# 頂点の偶奇の条件
even = [false] * n
even[root] = num[root].even?

g.bfs(root) do |v, nv|
  even[nv] = !even[v]
end

# 既に満たしていないならNO
n.times do |i|
  next if num[i] == -1
  next if even[i] && num[i].even?
  next if !even[i] && !num[i].even?

  puts "No"
  exit
end

# dfsで葉から取りうる範囲を順次決定
leaf = g.leaf(root)

INF = Int32::MAX//4
lo = -INF
hi = INF
ranges = [lo..hi] * n

g.dfs(root) do |v, dir|
  next if dir == Tree::ENTER

  # 葉の時
  if leaf[v]
    if num[v] != -1
      ranges[v] = num[v]..num[v]
    end
  else
    ranges[v] = num[v] == -1 ? lo..hi : num[v]..num[v]

    g[v].each do |nv|
      ranges[v] &= ranges[nv].widen
    end

    if ranges[v].empty?
      puts "No"
      exit
    end
  end
end

# 根から値を順次決定
g.bfs(root) do |v,nv|
  [-1, 1].each do |d|
    num[nv] = num[v] + d if ranges[nv].includes?(num[v] + d)
  end
end

puts "Yes"
puts num.join("\n")