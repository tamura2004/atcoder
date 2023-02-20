class CHT(T)
  getter a : Deque(Tuple(T,T))

  def initialize
    @a = Deque(Tuple(T,T)).new
  end

  # 傾きの降順、切片の降順で追加
  def <<(line : Tuple(T,T))
    while a.size >= 3
      if a[-1][0] == line[0] # 傾き一致
        a.pop
      elsif a[-1][0] < line[0]
        raise "bad slope"
      elsif a[-2][0]*(a[-2][1] - line[1]) + a[-2][1] * (a[-2][0] - line[0]) <= a[-1][0]*(a[-2][1] - line[1]) + a[-1][1] * (a[-2][0] - line[0])
        a.pop
      else
        break
      end
    end
    a << line
  end

  def max(x)
    while a.size >= 2
      if a[0][0] * x + a[0][1] >= a[1][0] * x + a[1][1]
        a.shift
      else
        break
      end
    end
    a[0][0] * x + a[0][1]
  end
end

cht = CHT(Float64).new
cht << {3.0,0.0}
cht << {0.5,5.0}
cht << {0.2,7.0}
cht << {-1.0,10.0}

(1..4).each do |i|
  pp cht.max(i)
end
