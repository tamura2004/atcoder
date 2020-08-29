class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
  end

  def dfs(init)
    que = [*init]
    while que.size > 0
      v = que.pop
      yield v,que
    end
  end

  def set_nv(v,m,que)
    1.upto(m) do |i|
      que << v + [i]
    end
  end

  def solve
    ans = []
    init = (1..n).map{ [_1+1] }

    dfs(init) do |v,que|
      x = v.sum
      m = [n-x,v.last].min
      if x == n
        ans << v 
      else
        set_nv(v,m,que) 
      end
    end
    ans    
  end

  def show(ans)
    puts ans.map{|v|v.join(" ")}.join("\n")
  end
end

Problem.new.instance_eval do
  show(solve)
end