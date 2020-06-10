n,k = gets.split.map(&:to_i)

MAX_PAIR = (n - 1) * (n - 2) / 2 # スターグラフの場合
MAX_EDGE = n * (n - 1) / 2 # 完全グラフの辺の数
if MAX_PAIR < k
  puts -1
  exit
end

def each_edge(n)
  1.upto(n-1) do |i|
    (i+1).upto(n) do |j|
      yield i,j
    end
  end
end

cnt = MAX_EDGE - k
puts cnt
each_edge(n) do |i,j|
  puts [i,j].join(" ")
  cnt -= 1
  exit if cnt == 0
end

