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
      # 候補より高いなら閉じないで積む
      if q.empty? || q[-1][0] < v
        q << {v, i}

      # 高い候補は取り除いて面積を計算
      else
        while q.size > 0 && q[-1][0] > v
          pv, pi = q.pop
          ans = Math.max ans, pv * (i - pi)
        end
        
        # 一つでも取り除いているならそれを候補にして積む
        q << {v, pi} if pi
      end
    end
    return ans
  end
end
