require "crystal/graph"
require "crystal/graph/bipartite_matching"
require "crystal/cc"
require "crystal/nex"

n, m = gets.to_s.split.map(&.to_i)
slots = Array.new(n) do
  Nex.new gets.to_s.chars.map(&.to_i), n
end

# slot iで、jが登場する時間最大n個
times = Array.new(n) do |i|
  (0...10).map do |j|
    if k = slots[i][j, 0]
      acc = [k]
      while acc.size < n && (nex = slots[i][j, acc[-1] + 1])
        acc << nex
      end
      acc
    else
      [] of Int32
    end
  end
end

# そろえる数をdと固定して全探索
10.times.min_of do |d|
  # 時刻xにおいてマッチング数がn以上になるか
  # 上記判定問題を二分探索
  lo = -1
  hi = n * m
  (lo..hi).bsearch do |x|
    # x以下の時刻とslotのペア
    pairs = [] of Tuple(Int32, Int32)
    times.each_with_index do |ts, i|
      ts[d].each do |t|
        break if x < t
        pairs << ({t, i})
      end
    end
    MaxBipartiteMatching.new(pairs).solve == n
  end || Int32::MAX
end.tap { |ans| pp ans == Int32::MAX ? -1 : ans }
