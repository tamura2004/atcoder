class DualSegmentTree(T)
  getter n : Int32  
  
  def initialize(values : T)
    @n = Math.pw2ceil(values.size)
    @a = Array(T?).new(n*2, nil.as(T?))

    # 区間代入
    @fx = Proc(T?,T?,T?).new do |x,y|
      x && y ? y : x ? x : y
    end

    values.each_with_index do |v, i|
      a[i + n] = v
    end
  end

  def [](i)

  end

  def []=(r, v)
  end
end
