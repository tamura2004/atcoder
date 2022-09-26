class Problem
  getter h : Int32
  getter row : Array(Int32)

  def initialize(@h)
    @row = Array.new(1 << h, 0)
  end

  def row(s)
    @row.fill(0)
    dfs(s, 0, 0)
    @row.dup
  end

  def dfs(s, t, i)
    case
    when i == h
      row[t] += 1
    when s.bit(i) == 1
      dfs(s, t, i + 1)
    else
      dfs(s, t, i + 1)
      dfs(s, t | (1 << i), i + 1)
      if i <= h - 2 && s.bit(i + 1) == 0
        dfs(s, t, i + 2)
      end
    end
  end
end

pr = Problem.new(3)
pp pr.row(7)
