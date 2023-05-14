h, w, t = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s }

# 開始、終了、クッキーのノード
class Node
  class_getter cookie_num = 0_i64
  enum Type
    START
    GOAL
    COOKIE
  end

  getter type : Type
  getter i : Int64
  getter pos : Tuple(Int32,Int32)

  def initialize(y,x,char)
    @pos = {y,x}
    case char
    when 'S'
      @type = Type::START
      @i = 0_i64
    when 'G'
      @type = Type::GOAL
      @i = 1_i64
    else
      @type = Type::COOKIE
      @@cookie_num += 1
      @i = @@cookie_num + 1
    end
  end
end

# ノードのみ集める
nodes = [] of Node
a.each_with_index do |row, y|
  row.chars.each_with_index do |c, x|
    next if c == '.' || c == '#'
    nodes << Node.new(y,x,c)
  end
end

# インデックスを貼っておく
i2node = nodes.group_by(&.i).transform_values(&.first)
pos2node = nodes.group_by(&.pos).transform_values(&.first)
n = i2node.keys.size

# 距離を保持するグラフ
g = Array.new(n){Array.new(n, Int64::MAX)}
n.times{|i|g[i][i] = 0_i64}

# 全ノード間の距離をBFSで求める
# キューに{y,x,dist}を持つ
# ただし、距離がtを超えるなら更新しない
a.each_with_index do |row, y|
  row.chars.each_with_index do |c, x|
    next if c == '.' || c == '#'
    q = Deque.new([{y,x,0_i64}])
    seen = Set(Tuple(Int32,Int32)).new
    i = pos2node[{y,x}].i
    seen << {y,x}
    while q.size > 0
      cy,cx,dist = q.shift
      if pos2node.has_key?({cy,cx})
        j = pos2node[{cy,cx}].i
        g[i][j] = dist
      end
      [{0,1},{0,-1},{1,0},{-1,0}].each do |dy,dx|
        ny = cy + dy
        nx = cx + dx
        next if ny < 0 || h <= ny || nx < 0 || w <= nx
        next if a[ny][nx] == '#'
        next if seen.includes?({ny,nx})
        seen << {ny,nx}
        next if t < dist + 1
        q << {ny,nx,dist+1}
      end
    end
  end
end

# 巡回セールスマンを解く
# dp[訪問済の集合][最後の位置] := 距離の最小値
dp = make_array(Int64::MAX, 1 << n, n)
start_index = nodes.find(&.type.start?).not_nil!.i
goal_index = nodes.find(&.type.goal?).not_nil!.i

quit -1 if t < g[start_index][goal_index]

dp[1<<start_index][start_index] = 0_i64

(1<<n).times do |s|
  n.times do |i|
    next if s.bit(i) == 0
    next if dp[s][i] == Int64::MAX
    n.times do |j|
      next if s.bit(j) == 1
      next if g[i][j] == Int64::MAX
      next if t < dp[s][i] + g[i][j]
      chmin dp[s | (1 << j)][j], dp[s][i] + g[i][j]
    end
  end
end

ans = 0_i64
(1<<n).times do |s|
  n.times do |i|
    next if i != goal_index
    next if dp[s][i] == Int64::MAX
    chmax ans, s.popcount - 2
  end
end

pp ans



