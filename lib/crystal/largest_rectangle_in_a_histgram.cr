# ヒストグラムの中の最大長方形の面積を求める
class LargestRectanbleInAHistgram
  getter n : Int32
  getter a : Array(Int64)

  def initialize(@n, @a)
  end

  def solve
    # 番兵
    a << 0_i64

    # 左端候補の高さと位置をスタックに積む
    q = Deque(Tuple(Int64, Int32)).new
    ans = 0_i64

    a.each_with_index do |v, i|
      # 左端候補より高いなら新たな左端候補として積む
      if q.empty? || q[-1][0] < v
        q << {v, i}

      # 左端候補より低いならその候補を確定
      else
        while q.size > 0 && q[-1][0] > v
          pv, pi = q.pop
          ans = Math.max ans, pv * (i - pi)
        end
        
        # 確定した一番左の候補を残す
        q << {v, pi} if pi
      end
    end
    return ans
  end
end
