# CHTによる1次関数の集合の管理
#
# f(x) = ax + bとしたとき,{a,b}を追加する
# {a,b}の降順ソート順に追加すること
# ```
# ```
class CHT
  alias T = Tuple(Int64, Int64)
  getter q : Deque(T)
  
  def initialize
    @q = Deque(T).new
  end
  
  # キューの末尾に f(x) = ax + bを追加する
  # {a,b}の降順ソート順に追加しないとbad order例外
  def <<(line)
    line = {line[0].to_i64, line[1].to_i64}
    while remove_tail?(line)
      q.pop
    end
    q << line
  end

  # 全てのf(x)についての最小値
  # 先頭から条件を満たさないf(x)を除去。ならし計算量O(N)
  def [](x)
    raise "bad. q is empty." if q.size.zero?
    while q.size > 1 && f(q[0],x) > f(q[1],x)
      q.shift
    end
    f(q[0], x)
  end

  def f(line,x)
    a,b = line
    a * x + b
  end

  # q := [...,{a1,b1},{a2,b2}] の末尾に{a3,b3}追加する際、
  # {a2,b2}が不要なら再帰的に取り除く判定。
  def remove_tail?(line)
    raise "bad order. #{q[-1]},#{line}" if q.size != 0 && q[-1] < line

    case q.size
    when 0 then false
    when 1
      a2, b2 = q[-1]
      a3, b3 = line
      a2 == a3 && b2 >= b3
    else
      a1, b1 = q[-2]
      a2, b2 = q[-1]
      a3, b3 = line
      over?(a1, b1, a2, b2, a3, b3)
    end
  end

  # 二直線の交点より上か
  def over?(a1, b1, a2, b2, a3, b3)
    (a2 - a1)*(b3 - b2) >= (b2 - b1)*(a3 - a2)
  end
end
