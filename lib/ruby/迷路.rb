DX = [ 0, 1, 0,-1, 1,-1, 1,-1]
DY = [ 1, 0,-1, 0, 1,-1,-1, 1]
INF = 10**9

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  attr_accessor :costs,:cy,:cx,:dy,:dx
  def initialize
    @h,@w = gets.split.map(&:to_i)
    @cy,@cx = gets.split.map(&:to_i).map{ _1 - 1 }
    @dy,@dx = gets.split.map(&:to_i).map{ _1 - 1 }
    @s = Array.new(h){ gets.chomp.tr(".#","01").chars.map(&:to_i) }
    @costs = Array.new(h){ Array.new(w,INF) }
  end

  def valid?(y,x,cost)
    return false if y < 0
    return false if h <= y
    return false if x < 0 || w <= x
    return false if s[y][x] == 1
    return false if costs[y][x] <= cost
    true
  end

  def each_walk(y,x,cost)
    4.times do |i|
      ny = y + DY[i]
      nx = x + DX[i]
      next if !valid?(ny,nx,cost)
      yield ny,nx
    end
  end

  def each_warp(y,x,cost)
    (y-2).upto(y+2) do |ny|
      (x-2).upto(x+2) do |nx|
        next if !valid?(ny,nx,cost)
        next if (ny-y).abs + (nx-x).abs <= 1
        yield ny,nx
      end
    end
  end

  def bfs(init)
    que = [init]
    while que.size > 0
      v = que.shift
      yield v, que
    end
  end

  def solve
    init = [cy,cx,0]
    costs[cy][cx] = 0
    bfs(init) do |v,que|
      y,x,cost = v
      return v if y == dy && x == dx 
      each_walk(y,x,cost) do |ny,nx|
        costs[ny][nx] = cost
        que.unshift [ny,nx,cost]
      end
      each_warp(y,x,cost+1) do |ny,nx|
        costs[ny][nx] = cost + 1
        que << [ny,nx,cost+1]
      end
    end
    return -1
  end

  def show(ans)
    y,x,cost = ans
    puts ans == -1 ? -1 : cost
  end
end

Problem.new.instance_eval do
  show(solve)
  # pp costs
end